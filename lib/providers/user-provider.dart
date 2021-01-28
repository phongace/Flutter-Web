import 'package:flutter/cupertino.dart';
import 'package:time_store/models/user/user.dart';
import 'package:time_store/utils/share-preference.dart';

class UserProvider extends ChangeNotifier {
  List<User> users = [];

  User user;

  void registerUser(String username, String pass) {
    var newUser = User(userId: users.length + 1, username: username, password: pass, rePassword: pass);
    users.add(newUser);
    print(users);
    SharedPrefsService.setUsername(username);
    SharedPrefsService.setPassword(pass);
    notifyListeners();
  }
}
