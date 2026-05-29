import 'package:flutter/material.dart';

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.black87,
    Duration duration = const Duration(seconds: 2),
    TextStyle? textStyle,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textStyle ?? const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.redAccent,
      duration: duration,
    );
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.green,
      duration: duration,
    );
  }
}
