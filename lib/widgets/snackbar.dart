import 'package:flutter/material.dart';

abstract class SnackbarBuilder {
  static void showSnackBar(BuildContext c, String text, Color color) {
    ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        backgroundColor: color,
        content: Text(text),
      ),
    );
  }
}
