import 'package:flutter/material.dart';

class UIConstants {
  static double getSafeHeight(BuildContext context) =>
      MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom -
      AppBar().preferredSize.height;

  static double getSafeWidth(BuildContext context) =>
      MediaQuery.of(context).size.width -
      MediaQuery.of(context).padding.left -
      MediaQuery.of(context).padding.right;

  static double getPaddingHorizontal(BuildContext context) =>
      getSafeWidth(context) * .02;

  static double getPaddingVertical(BuildContext context) =>
      getSafeHeight(context) * .02;

  static double getColumnSpacing(BuildContext context) =>
      getSafeHeight(context) * .02;

  static double getRowSpacing(BuildContext context) =>
      getSafeWidth(context) * .02;

  static bool platformIsWeb(BuildContext context) =>
      MediaQuery.of(context).size.width > 500;

  /// get a responsive height with minimal
  /// [height] = 18 and a [multiplier] = .025
  /// [height] and [multiplier] can be changed if wanted
  static double getHeight(BuildContext context,
          {double height = 18, double multiplier = .025}) =>
      UIConstants.getSafeHeight(context) * multiplier < height
          ? height
          : UIConstants.getSafeHeight(context) * multiplier;

  /// get a responsive width with maximum
  /// [width] = 500 and a [multiplier] = .9
  /// [width] and [multiplier] can be changed if wanted
  static double getWidth(BuildContext context,
          {double width = 500, double multiplier = .9}) =>
      UIConstants.getSafeWidth(context) * multiplier > width
          ? width
          : UIConstants.getSafeWidth(context) * multiplier;
}
