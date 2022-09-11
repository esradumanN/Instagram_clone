import 'package:flutter/cupertino.dart';
import '../core/constants/app_colors.dart';
import '../main.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({
    Key? key,
    required this.title,
    required this.func,
  }) : super(key: key);
  final String title;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
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
            child: Text(
          title,
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
