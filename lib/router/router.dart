import 'package:flutter/material.dart';
import 'package:time_store/router/routing-name.dart';
import 'package:time_store/screens/authenticate/login.dart';
import 'package:time_store/screens/authenticate/register.dart';
import 'package:time_store/screens/home/home-page.dart';

abstract class RoutesConstant {
  static final routes = <String, WidgetBuilder>{
    RoutingNameConstant.Login: (BuildContext context) => new LoginPage(),
    RoutingNameConstant.Register: (BuildContext context) => new RegisterPage(),
    RoutingNameConstant.Home: (BuildContext context) => new HomePage(),
  };
}
