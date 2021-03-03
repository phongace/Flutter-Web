import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:time_store/config/constant.dart';
import 'package:time_store/models/common/token.dart';
import 'package:time_store/plugin/locator.dart';
import 'package:time_store/plugin/navigator.dart';
import 'package:time_store/repsonse/response-data.dart';
import 'package:time_store/router/routing-name.dart';
import 'package:time_store/utils/share-preference.dart';
import 'package:time_store/widgets/snackbar.dart';

final NavigationService _navigationService = locator<NavigationService>();

Dio http = Dio(
  BaseOptions(
    connectTimeout: 10000,
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ),
)..interceptors.addAll([buildInterceptorsWrapper()]);

buildInterceptorsWrapper() {
  return InterceptorsWrapper(
    onRequest: (RequestOptions requestOptions) async {
      http.interceptors.requestLock.lock();
      TokenObj tokenObj = await SharedPrefsService.getTokenObj();
      if (tokenObj != null && tokenObj.accessToken != null && tokenObj.accessToken != '') {
        requestOptions.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + tokenObj.accessToken;
        http.interceptors.requestLock.unlock();
        return requestOptions;
      }
      http.interceptors.requestLock.unlock();
      return requestOptions;
    },
    onResponse: (Response response) async {
      // Do something with response data
      if (response != null && response.data != null) {
        if (response.data['status'] != null) {
          response.data['status'] = response.data['status'] == Constant.sucessText;
        }
        ResponseData responseData = ResponseData.fromJson(response.data);
        String message = responseData.message ?? null;
        bool status = responseData.status;
        if (message != null && status != null) {
          String msg;
          Color color = status ? Colors.blue[700] : Colors.red;
          msg = message;
          SnackbarBuilder.showSnackBar(_navigationService.getContext(), msg, color);
        }
        response.data = responseData;
        print(response);
        return response;
      }
      return response; // continue
    },
    onError: (DioError error) async {
      try {
        switch (error.type) {
          case DioErrorType.CANCEL:
            print('Request Cancelled');
            break;
          case DioErrorType.CONNECT_TIMEOUT:
            print('DioErrorType.CONNECT_TIMEOUT');
            break;
          case DioErrorType.DEFAULT:
            print('DioErrorType.DEFAULT');
            break;
          case DioErrorType.RECEIVE_TIMEOUT:
            print('DioErrorType.RECEIVE_TIMEOUT');
            break;
          case DioErrorType.RESPONSE:
            print('Request with response error ${error.response}');
            if ((error.response?.statusCode == 401 || error.response?.statusCode == 403)) {
              _navigationService.navigatePushAndRemoveUntil(RoutingNameConstant.Login);
              SnackbarBuilder.showSnackBar(
                _navigationService.getContext(),
                'You need to login to continue',
                Colors.red,
              );
            }
            break;
          case DioErrorType.SEND_TIMEOUT:
            break;
        }
      } catch (e) {}
    },
  );
}
