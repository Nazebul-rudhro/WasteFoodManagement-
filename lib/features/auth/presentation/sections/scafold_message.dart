import 'package:flutter/material.dart';

class ScaffoldMessage {
  /// Shows a SnackBar with a given message and optional color
  static void show(BuildContext context, String message,
      {Color backgroundColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
