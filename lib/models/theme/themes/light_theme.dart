import 'package:flutter/material.dart';

import '../own_theme_fields.dart';

class LightTheme {
  static final Color customGreen = Color.fromRGBO(94, 119, 3, 1);
  static final Color customBeige = Color.fromRGBO(244, 226, 198, 1);
  ThemeData _themeData = ThemeData()
    ..addOwn(OwnThemeFields(
        background: customBeige,
        popUpBackground: customBeige,
        popUpTextInputColor: Colors.grey[600]!,
        inputFieldBorder: customGreen,
        yacmLogoColor: customGreen,
        popUpLogin: customBeige,
        popUpLoginBackground: customGreen,
        popUpSignUp: customGreen,
        popUpClose: Colors.grey[600]!,
        popUpInterestsRadio: customGreen,
        popUpInterestsText: Colors.grey[600]!,
        popUpHeaderText: customGreen));

  LightTheme();

  ThemeData getTheme() => _themeData;
}
