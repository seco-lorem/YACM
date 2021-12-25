import 'package:flutter/material.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import '../../models/theme/themes/dark_theme.dart';
import '../../models/theme/themes/light_theme.dart';
import '../shared_pref_controller/sp_controller.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData? _themeData;
  static final Color customGreen = Color.fromRGBO(94, 119, 3, 1);
  static final Color customBeige = Color.fromRGBO(244, 226, 198, 1);
  static final Color customBeigeDark = Color.fromRGBO(224, 205, 178, 1);
  static final Color customDarkBlue = Color(0xff00000f);

  ThemeChanger(bool dark) {
    if (dark) {
      _themeData = ThemeData()
        ..addOwn(OwnThemeFields(
            background: customDarkBlue,
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
            popUpHeaderText: Colors.white,
            postSettings: Colors.white,
            postSettingsText: Colors.black,
            gridPostText: Colors.white,
            clubProfileFooterAdd: Colors.white,
            optionColor: Colors.white,
            optionText: Colors.grey[700]!,
            appBar: Colors.black,
            appBarText: Colors.white));
    } else {
      _themeData = ThemeData()
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
    }
  }

  ThemeData? getTheme() => _themeData;

  bool setTheme(bool dark) {
    try {
      if (dark) {
        print("dark");
        _themeData = ThemeData()
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
              optionText: customBeige,
              appBar: customDarkBlue,
              appBarText: customBeige));
      } else {
        print("light");
        _themeData = ThemeData()
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
