import 'package:flutter/material.dart';

class BaseSnackbarWidget {
  static void showOverlaySnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required TextStyle style,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: style,
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
