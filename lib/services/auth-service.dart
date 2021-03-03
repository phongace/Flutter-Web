import 'package:time_store/config/constant.dart';
import 'package:time_store/plugin/dio.dart';
import 'package:time_store/repsonse/response-data.dart';

class AuthService {
  static Future<ResponseData> login(Map data) async {
    try {
      var response = await http.post(Constant.apiUrl + 'login', data: data);
      ResponseData responseData = response.data;
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
