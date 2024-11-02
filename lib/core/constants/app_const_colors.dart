import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppColors {
  // https://rydmike.com/flexcolorscheme/themesplayground-latest/
  // Bahama Blue colors:
  // static const primary = Color(0xFF285C99);
  // static const heart = Color(0xFFDD520F);
  // static const error = Color(0xFFB1384E);
  static const primary = Color(0xFF023047);
  static const heart = Color(0xFFF86541);
  static const error = Color(0xFFB00020);
  static Color greyShade200(bool isLight) =>
      isLight ? Colors.grey.shade200 : Colors.grey.shade900;
  static Color greyShade300(bool isLight) =>
      isLight ? Colors.grey.shade300 : Colors.grey.shade800;
  static Color greyShade400(bool isLight) =>
      isLight ? Colors.grey.shade400 : Colors.grey.shade700;
  static Color greyShade500(bool isLight) =>
      isLight ? Colors.grey.shade500 : Colors.grey.shade600;

  static const flexScheme = FlexScheme.bahamaBlue;
}
