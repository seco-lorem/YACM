import 'package:flutter/material.dart';

class OwnThemeFields {
  final Color background;
  final Color popUpBackground;
  final Color popUpTextInputColor;
  final Color inputFieldBorder;
  final Color yacmLogoColor;
  final Color popUpLogin;
  final Color popUpLoginBackground;
  final Color popUpSignUp;
  final Color popUpClose;
  final Color popUpInterestsText;
  final Color popUpInterestsRadio;
  final Color popUpHeaderText;
  final Color postSettings;
  final Color postSettingsText;
  final Color gridPostText;
  final Color clubProfileFooterAdd;
  final Color optionColor;
  final Color optionText;
  final Color appBarText;
  final Color appBar;

  const OwnThemeFields(
      {required this.background,
      required this.popUpBackground,
      required this.inputFieldBorder,
      required this.popUpTextInputColor,
      required this.yacmLogoColor,
      required this.popUpLogin,
      required this.popUpLoginBackground,
      required this.popUpSignUp,
      required this.popUpClose,
      required this.popUpInterestsRadio,
      required this.popUpInterestsText,
      required this.popUpHeaderText,
      required this.postSettings,
      required this.postSettingsText,
      required this.gridPostText,
      required this.clubProfileFooterAdd,
      required this.optionColor,
      required this.optionText,
      required this.appBarText,
      required this.appBar});

  factory OwnThemeFields.empty() {
    return OwnThemeFields(
      background: Colors.black,
      popUpBackground: Colors.black,
      popUpTextInputColor: Colors.black,
      inputFieldBorder: Colors.black,
      yacmLogoColor: Colors.black,
      popUpLogin: Colors.black,
      popUpLoginBackground: Colors.black,
      popUpSignUp: Colors.black,
      popUpClose: Colors.black,
      popUpInterestsRadio: Colors.black,
      popUpInterestsText: Colors.black,
      popUpHeaderText: Colors.black,
      postSettings: Colors.black,
      postSettingsText: Colors.black,
      gridPostText: Colors.black,
      clubProfileFooterAdd: Colors.black,
      optionColor: Colors.black,
      optionText: Colors.black,
      appBarText: Colors.black,
      appBar: Colors.black,
    );
  }
}

extension ThemeDataExtensions on ThemeData {
  static Map<InputDecorationTheme, OwnThemeFields> _own = {};

  void addOwn(OwnThemeFields own) {
    // can't use reference to ThemeData since Theme.of() can create a new localized instance from the original theme. Use internal fields, in this case InputDecoreationTheme reference which is not deep copied but simply a reference is copied
    _own[this.inputDecorationTheme] = own;
  }

  static OwnThemeFields? empty;

  OwnThemeFields own() {
    var o = _own[this.inputDecorationTheme];
    if (o == null) {
      if (empty == null) empty = OwnThemeFields.empty();
      o = empty;
    }
    return o!;
  }
}

OwnThemeFields ownTheme(BuildContext context) => Theme.of(context).own();
