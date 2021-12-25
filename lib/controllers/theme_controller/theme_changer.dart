import 'package:flutter/material.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import '../shared_pref_controller/sp_controller.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData? _themeData;
  static final Color customGreen = Color.fromRGBO(94, 119, 3, 1);
  static final Color customBeige = Color.fromRGBO(244, 226, 198, 1);
  static final Color customBeigeDark = Color.fromRGBO(224, 205, 178, 1);
  static final Color customDarkBlue = Color(0xff00000f);

  static final ThemeData _lightThemeData = ThemeData()
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
      appBarText: customBeige,
      commentWidgetComment: Colors.grey[700]!,
      commentWidgetDate: customGreen,
      commentWidgetName: customGreen,
      pollWidgetOption: customGreen,
      pollWidgetQuestion: customGreen,
      postWidgetDivider: customGreen,
      postWidgetIcons: customGreen,
    ));

  static final ThemeData _darkThemeData = ThemeData()
    ..addOwn(OwnThemeFields(
        background: customDarkBlue,
        popUpBackground: customDarkBlue,
        popUpTextInputColor: customBeige,
        inputFieldBorder: customBeige,
        yacmLogoColor: customBeige,
        popUpLogin: customBeige,
        popUpLoginBackground: customDarkBlue,
        popUpSignUp: customBeige,
        popUpClose: customBeige,
        popUpInterestsRadio: customBeige,
        popUpInterestsText: customBeige,
        popUpHeaderText: customBeige,
        postSettings: customBeige,
        postSettingsText: customDarkBlue,
        gridPostText: customBeige,
        clubProfileFooterAdd: customBeige,
        optionColor: customBeige,
        optionText: customDarkBlue,
        appBar: customDarkBlue,
        appBarText: customBeige,
        commentWidgetComment: customBeige,
        commentWidgetDate: customBeige,
        commentWidgetName: customBeige,
        pollWidgetOption: customDarkBlue,
        pollWidgetQuestion: customBeige,
        postWidgetDivider: customBeige,
        postWidgetIcons: customBeige));

  ThemeChanger(bool dark) {
    if (dark) {
      _themeData = _darkThemeData;
    } else {
      _themeData = _lightThemeData;
    }
  }

  ThemeData? getTheme() => _themeData;

  bool setTheme(bool dark) {
    try {
      if (dark) {
        print("dark");
        _themeData = _darkThemeData;
      } else {
        print("light");
        _themeData = _lightThemeData;
      }
      SPController.setBoolValue("darkTheme", dark);
      print(_themeData);
      notifyListeners();
      return true;
    } catch (error) {
      throw Exception("Could not set theme.\nError ${error.toString()}");
    }
  }
}
