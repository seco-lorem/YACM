import 'package:flutter/material.dart';

import '../own_theme_fields.dart';

class LightTheme {
  ThemeData _themeData = ThemeData(
      backgroundColor: Color.fromRGBO(244, 226, 198, 1),
      primaryColor: Color.fromRGBO(30, 215, 96, 1))
    ..addOwn(OwnThemeFields(
        // general colors
        generalReturnColor: Colors.grey,
        // login button
        loginButtonBackground: Color.fromRGBO(30, 215, 96, 1),
        loginButtonText: Color.fromRGBO(244, 226, 198, 1),
        loginButtonBorder: Color.fromRGBO(244, 226, 198, 1),
        // login sign up
        loginDontHaveAccount: Colors.grey,
        loginSignUp: Colors.grey[600],
        // login mail input
        loginMailInputBorder: Color.fromRGBO(30, 215, 96, 1),
        loginMailText: Colors.grey,
        loginMailBackground: Color.fromRGBO(244, 226, 198, 1),
        // login password input
        loginPasswordInputBorder: Color.fromRGBO(30, 215, 96, 1),
        loginPasswordText: Colors.grey,
        loginPasswordBackground: Color.fromRGBO(244, 226, 198, 1),
        // login checkbox
        loginCheckBoxActiveColor: Color.fromRGBO(30, 215, 96, 1),
        loginCheckBoxText: Colors.grey,
        // login appname
        loginAppNameColor: Color.fromRGBO(30, 215, 96, 1),
        // sign up bottom scroller
        signUpBottomScrollerDots: Colors.grey,
        signUpBottomScrollerText: Color.fromRGBO(30, 215, 96, 1),
        signUpBottomScrollerCurrentDot: Colors.grey[600],
        signUpGetNameBackground: Color.fromRGBO(244, 226, 198, 1),
        signUpGetNameText: Colors.grey,
        signUpGetNameBorder: Color.fromRGBO(30, 215, 96, 1),
        signUpWelcomerText: Color.fromRGBO(30, 215, 96, 1),
        signUpGetIDBackground: Color.fromRGBO(244, 226, 198, 1),
        signUpGetIDBorder: Color.fromRGBO(30, 215, 96, 1),
        signUpGetIDHeaderText: Colors.grey,
        signUpGetIDText: Colors.grey,
        signUpGetDepartmentBorder: Color.fromRGBO(30, 215, 96, 1),
        signUpGetDepartmentBackground: Color.fromRGBO(244, 226, 198, 1),
        signUpGetDepartmentHeaderText: Colors.grey,
        signUpGetDepartmentChoiceText: Colors.grey,
        signUpGetDepartmentDivider: Color.fromRGBO(30, 215, 96, 1),
        signUpGetPhotoButtonColor: Color.fromRGBO(30, 215, 96, 1),
        signUpGetPhotoButtonText: Color.fromRGBO(244, 226, 198, 1),
        signUpGetInterestsChoiceText: Color.fromRGBO(30, 215, 96, 1),
        signUpGetInterestsText: Colors.grey,
        signUpGetPasswordBackground: Color.fromRGBO(244, 226, 198, 1),
        signUpGetPasswordBorder: Color.fromRGBO(30, 215, 96, 1),
        signUpGetPasswordHeader: Colors.grey,
        signUpGetPasswordText: Colors.grey));

  LightTheme();

  ThemeData getTheme() => _themeData;
}
