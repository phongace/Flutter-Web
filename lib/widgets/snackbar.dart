import 'package:flutter/material.dart';

void showSBar(BuildContext c, String text) {
  ScaffoldMessenger.of(c).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 2000),
      backgroundColor: Colors.blue[400],
      content: Text(text),
    ),
  );
}
