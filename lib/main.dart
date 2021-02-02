import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_store/providers/comments-provider.dart';
import 'package:time_store/providers/data-table-provider.dart';
import 'package:time_store/providers/user-provider.dart';
import 'package:time_store/router/router.dart';
import 'package:time_store/screens/authenticate/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => DataTableProvider()),
        ChangeNotifierProvider(create: (context) => CommentProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: RoutesConstant.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
