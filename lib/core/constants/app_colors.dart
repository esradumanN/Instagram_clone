import 'package:flutter/cupertino.dart';

class AppColors {
  // create a sigleton

  static final AppColors _singleton = AppColors._internal();
  factory AppColors() => _singleton;
  AppColors._internal();
  static Color lightBlue = const Color(0xFF3797EF);
  static Color blue = const Color(0xFF00629B);
  static Color darkBlue = const Color(0xFF003865);
  static Color black = const Color(0xFF011947);
  static Color grey = const Color(0xFF707070);
  static Color lightGrey = const Color(0xFFC7C7CC);
  static Color white = const Color(0xFFFFFFFF);
  static Color textGrey = const Color(0xFF262626);
  static Color inputBorder = const Color(0xFF99ACCF);
  static Color appbar = const Color.fromRGBO(249, 249, 249, 1);
  static Color Linear1 = const Color(0xFFFBAA47);
  static Color Linear2 = const Color(0xFFD91A46);
  static Color Linear3 = const Color(0xFFA60F93);
}
