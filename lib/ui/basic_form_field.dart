import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../main.dart';

class BasicFormField extends StatelessWidget {
  const BasicFormField({
    Key? key,
    required this.maxLines,
    required this.w,
    required this.controller,
  }) : super(key: key);
  final int maxLines;
  final double w;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        cursorHeight: sizeHelper.getHeight(22),
        onChanged: (value) {
          debugPrint(value);
        },
        decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(
              left: sizeHelper.getWidth(10),
              right: sizeHelper.getWidth(10),
              top: sizeHelper.getHeight(12),
              bottom: sizeHelper.getHeight(12),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            errorBorder: _outlineInputBorder(),
            enabledBorder: _outlineInputBorder(),
            focusedBorder: _outlineInputBorder(),
            focusedErrorBorder: _outlineInputBorder()),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5)),
      borderRadius: const BorderRadius.all(
        Radius.circular(13),
      ),
    );
  }
}
