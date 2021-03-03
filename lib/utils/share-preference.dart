import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_store/models/common/token.dart';

class SharedPrefsService {
  static TokenObj tokenObj;

  static Future<TokenObj> setTokenObj(String str) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', str);
    Map map = jsonDecode(str);
    tokenObj = TokenObj.fromJson(map);
    return tokenObj;
  }

  static Future<TokenObj> getTokenObj() async {
    try {
      if (tokenObj?.accessToken == null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString('token');
        if (token == null || token == '') {
          return null;
        }
        Map map = jsonDecode(token);
        tokenObj = TokenObj.fromJson(map);
        return tokenObj;
      } else {
        return tokenObj;
      }
    } catch (e) {
      return null;
    }
  }

  static removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  static setUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  static setPassword(String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('password', pass);
  }

  static getUsername() async {
    var prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    if (username == null) {
      return null;
    } else {
      return username;
    }
  }

  static getPassword() async {
    var prefs = await SharedPreferences.getInstance();
    String pass = prefs.getString('password');
    if (pass == null) {
      return null;
    } else {
      return pass;
    }
  }
}
