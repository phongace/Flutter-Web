import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_store/plugin/locator.dart';
import 'package:time_store/plugin/navigator.dart';
import 'package:time_store/providers/comments-provider.dart';
import 'package:time_store/providers/data-table-provider.dart';
import 'package:time_store/providers/token-provider.dart';
import 'package:time_store/providers/user-provider.dart';
import 'package:time_store/router/router.dart';
import 'package:time_store/wrapper.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TokenProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => DataTableProvider()),
        ChangeNotifierProvider(create: (context) => CommentProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      routes: RoutesConstant.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Wrapper(),
    );
  }
}
