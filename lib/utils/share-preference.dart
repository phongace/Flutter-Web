import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
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
