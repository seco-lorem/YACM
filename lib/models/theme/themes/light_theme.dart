import 'package:flutter/material.dart';

import '../own_theme_fields.dart';

class LightTheme {
  static final Color customGreen = Color.fromRGBO(94, 119, 3, 1);
  static final Color customBeige = Color.fromRGBO(244, 226, 198, 1);
  static final Color customBeigeDark = Color.fromRGBO(224, 205, 178, 1);
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
        popUpHeaderText: customGreen,
        postSettings: customBeige,
        postSettingsText: customGreen,
        gridPostText: customGreen,
        clubProfileFooterAdd: customGreen,
        optionColor: customGreen,
        optionText: customBeige,
        appBar: customGreen,
        appBarText: customBeige));

  LightTheme();

  ThemeData getTheme() => _themeData;
}
