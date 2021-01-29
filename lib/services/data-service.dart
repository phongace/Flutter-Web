import 'dart:async';

import 'package:dio/dio.dart';
import 'package:time_store/config/constant.dart';
import 'package:time_store/models/data-table/data.dart';

class DataService {
  static Future<List<Data>> fetchData() async {
    try {
      final response = await Dio().get(Constant.apiUrl);
      var data = response.data;
      List<dynamic> list = List.from(data);
      List<Data> listData = list.map((d) => Data.fromJson(d)).toList();
      return listData;
    } catch (e) {
      return [];
    }
  }
}
