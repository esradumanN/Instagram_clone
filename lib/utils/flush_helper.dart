import 'package:flutter/material.dart';

class FlushHelper {
  static void flush({
    required BuildContext context,
    required String message,
    required FlushType type,
  }) {
    Color color = Colors.black;
    switch (type) {
      case FlushType.success:
        color = Colors.green.shade200;
        break;
      case FlushType.fail:
        color = Colors.red.shade200;
        break;
      case FlushType.info:
        color = Colors.blue.shade200;
        break;
      default:
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color,
        elevation: 10,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ));
    });
  }
}

enum FlushType {
  success,
  fail,
  info,
}
