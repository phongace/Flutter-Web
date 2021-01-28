import 'package:flutter/material.dart';
import 'package:time_store/screens/home/widgets/custom-paginated-table.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Center(
        child: CustomPaginatedTale(),
      ),
    );
  }
}
