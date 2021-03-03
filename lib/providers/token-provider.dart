import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:time_store/models/common/token.dart';
import 'package:time_store/utils/share-preference.dart';

class TokenProvider extends ChangeNotifier {
  TokenObj get tokenObj => _tokenObj;

  TokenObj _tokenObj;

  bool get isLogged => _isLogged;

  bool _isLogged = false;

  Future<bool> getTokenObj() async {
    _tokenObj = await SharedPrefsService.getTokenObj();
    if (_tokenObj != null && _tokenObj.accessToken != null && _tokenObj.accessToken != '') {
      _isLogged = true;
    } else {
      _isLogged = false;
    }
    notifyListeners();
    return _isLogged;
  }

  Future<void> setTokenObj(String str) async {
    await SharedPrefsService.setTokenObj(str);
    Map map = jsonDecode(str);
    _tokenObj = TokenObj.fromJson(map);
    _isLogged = true;
    notifyListeners();
  }

  void removeToken() async {
    await SharedPrefsService.removeToken();
    _tokenObj = new TokenObj();
    _isLogged = false;
    notifyListeners();
  }
}
