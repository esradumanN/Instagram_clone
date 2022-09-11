import 'package:flutter/material.dart';

class PushHelper {
  static void push({required BuildContext context, required Widget to}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => to));
  }
}
