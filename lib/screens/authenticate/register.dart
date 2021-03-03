import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_store/providers/user-provider.dart';
import 'package:time_store/router/routing-name.dart';
import 'package:time_store/widgets/base-input.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _username = TextEditingController();
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
                    onSubmitted: (val) => register(),
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
                      onPressed: () => register(),
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

  void register() {
    if (_formKey.currentState.validate()) {
      final user = Provider.of<UserProvider>(context, listen: false);
      user.registerUser(_username.text, _pass.text);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 1000),
          backgroundColor: Colors.blue[400],
          content: const Text('Register success!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 2000),
          backgroundColor: Colors.red[400],
          content: const Text('Register fail!'),
        ),
      );
    }
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
