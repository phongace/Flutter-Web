import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_store/providers/token-provider.dart';
import 'package:time_store/router/routing-name.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadNextScreen());
  }

  _loadNextScreen() async {
    bool isLogged = await Provider.of<TokenProvider>(context, listen: false).getTokenObj();
    print('isLogged: ${isLogged.toString()}');
    if (!isLogged) {
      Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstant.Login, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstant.Home, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
