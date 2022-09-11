import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../main.dart';

class BlueButtonLoading extends StatelessWidget {
  const BlueButtonLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeHelper.getHeight(44),
      width: sizeHelper.getWidth(343),
      decoration: BoxDecoration(
        color: AppColors.lightBlue.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightBlue.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(-1, 5),
          ),
        ],
      ),
      child: Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      )),
    );
  }
}
