import 'package:flutter/material.dart';

import '../own_theme_fields.dart';

class DarkTheme {
  ThemeData _themeData = ThemeData()
    ..addOwn(OwnThemeFields(
        background: Colors.black,
        popUpBackground: Colors.grey[850]!,
        popUpTextInputColor: Colors.white,
        inputFieldBorder: Colors.white,
        yacmLogoColor: Colors.white,
        popUpLogin: Colors.black,
        popUpLoginBackground: Colors.white,
        popUpSignUp: Colors.white,
        popUpClose: Colors.grey[700]!,
        popUpInterestsRadio: Colors.white,
        popUpInterestsText: Colors.white,
        popUpHeaderText: Colors.white));

  DarkTheme();

  ThemeData getTheme() => _themeData;
}
