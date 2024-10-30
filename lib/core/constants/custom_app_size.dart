import 'package:flutter/material.dart';

class AppSizing {
  /// Returns the width of the screen. Useful for making responsive layouts.
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// Returns the height of the screen. Helps adjust UI based on the height.
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// Checks if the device screen width is less than 480 (mobile screen size).
  static bool isMobile(BuildContext context) => width(context) < 480;

  /// Checks if the device screen width is between 480 and 895 (tablet size).
  static bool isTablet(BuildContext context) =>
      width(context) > 480 && width(context) < 895;

  /// Checks if the device screen width is greater than 895 (desktop size).
  static bool isDesktop(BuildContext context) => width(context) > 895;

  /// Returns a SizedBox with height set to 2% of the screen height. Useful for vertical spacing.
  static SizedBox k20(BuildContext context) =>
      SizedBox(height: height(context) * 0.02);

  /// Returns a SizedBox with height set to 1% of the screen height. Useful for smaller vertical spacing.
  static SizedBox k10(BuildContext context) =>
      SizedBox(height: height(context) * 0.01);

  /// Returns a SizedBox with width relative to a factor of the screen width. Helpful for horizontal spacing.
  static SizedBox kwSpacer(BuildContext context, double factor) =>
      SizedBox(width: width(context) * factor);
}
