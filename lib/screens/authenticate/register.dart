import 'package:flutter/material.dart';
import 'package:time_store/router/routing-name.dart';
import 'package:time_store/services/auth-service.dart';
import 'package:time_store/widgets/base-input.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _username = TextEditingController();
  var _emailCltr = TextEditingController();
  var _pass = TextEditingController();
  var _rePass = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      child: Row(
        children: [
          Container(
            width: size.width * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg-register.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                    hint: 'Email',
                    textCtrl: _emailCltr,
                    validator: (val) => val.isEmpty ? "Email không được để trống!" : null,
                  ),
                  const SizedBox(height: 18),
                  BaseTextInput(
                    hint: 'Mật khẩu',
                    textCtrl: _pass,
                    obscureText: true,
                    validator: (val) => val.isEmpty ? "Password không được để trống!" : null,
                  ),
                  const SizedBox(height: 18),
                  BaseTextInput(
                    hint: 'Nhập lại mật khẩu',
                    textCtrl: _rePass,
                    obscureText: true,
                    validator: (val) => val.isEmpty
                        ? "Password không được để trống!"
                        : val != _pass.text
                            ? "Nhập lại mật khẩu chưa đúng!"
                            : null,
                    onSubmitted: (val) {
                      _handleRegister().then((value) {
                        if (value) {
                          Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstant.Login, (route) => false);
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
                        'Đăng ký',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        _handleRegister().then((value) {
                          if (value) {
                            Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstant.Login, (route) => false);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Bạn đã có tài khoản?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(
                            color: Colors.yellow[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () => Navigator.pushNamed(context, RoutingNameConstant.Login),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _handleRegister() async {
    if (!_formKey.currentState.validate()) {
      return false;
    }
    Map map = new Map();
    map['name'] = _username.text;
    map['email'] = _emailCltr.text;
    map['password'] = _pass.text;
    final response = await AuthService.register(map);
    if (response.data == null) {
      return false;
    }
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
