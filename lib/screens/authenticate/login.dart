import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_store/providers/token-provider.dart';
import 'package:time_store/router/routing-name.dart';
import 'package:time_store/services/auth-service.dart';
import 'package:time_store/widgets/base-input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _username = TextEditingController();
  var _pass = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            width: size.width * 0.4,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Spacer(),
                  _logo(),
                  const SizedBox(height: 30),
                  BaseTextInput(
                    hint: 'Username',
                    textCtrl: _username,
                    validator: (val) => val.isEmpty ? "Username không được để trống!" : null,
                  ),
                  const SizedBox(height: 18),
                  BaseTextInput(
                    hint: 'Password',
                    textCtrl: _pass,
                    obscureText: true,
                    validator: (val) => val.isEmpty ? "Password không được để trống!" : null,
                    onSubmitted: (value) {
                      _handleLogin().then((value) {
                        if (value) {
                          Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstant.Home, (route) => false);
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: size.width,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextButton(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        _handleLogin().then((value) {
                          if (value) {
                            Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstant.Home, (route) => false);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Bạn chưa có tài khoản?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(
                            color: Colors.yellow[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () => Navigator.pushNamed(context, RoutingNameConstant.Register),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          Container(
            width: size.width * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _handleLogin() async {
    if (!_formKey.currentState.validate()) {
      return false;
    }
    Map map = new Map();
    map['email'] = _username.text;
    map['password'] = _pass.text;
    final response = await AuthService.login(map);
    if (response.data == null) {
      return false;
    }
    Provider.of<TokenProvider>(context, listen: false).setTokenObj(jsonEncode(response.data));
    return true;
  }

  Widget _logo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/logo.png',
          width: 30,
        ),
        const SizedBox(width: 15),
        Text(
          'Time',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(width: 2),
        Text(
          'Store',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
          ),
        ),
      ],
    );
  }
}
