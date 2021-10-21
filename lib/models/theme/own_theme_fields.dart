import 'package:flutter/material.dart';

class OwnThemeFields {
  // General Colors
  final Color? generalReturnColor;
  // General Colors End
  // Login Page Colors
  final Color? loginButtonBackground;
  final Color? loginButtonText;
  final Color? loginButtonBorder;
  final Color? loginDontHaveAccount;
  final Color? loginSignUp;
  final Color? loginMailBackground;
  final Color? loginMailInputBorder;
  final Color? loginMailText;
  final Color? loginPasswordBackground;
  final Color? loginPasswordText;
  final Color? loginPasswordInputBorder;
  final Color? loginCheckBoxActiveColor;
  final Color? loginCheckBoxText;
  final Color? loginAppNameColor;
  // Login Page Colors End

  // Sign Up Page Colors
  final Color? signUpBottomScrollerText;
  final Color? signUpBottomScrollerDots;
  final Color? signUpBottomScrollerCurrentDot;
  final Color? signUpWelcomerText;
  final Color? signUpGetNameBorder;
  final Color? signUpGetNameBackground;
  final Color? signUpGetNameText;
  final Color? signUpGetIDHeaderText;
  final Color? signUpGetIDText;
  final Color? signUpGetIDBorder;
  final Color? signUpGetIDBackground;
  final Color? signUpGetDepartmentBorder;
  final Color? signUpGetDepartmentBackground;
  final Color? signUpGetDepartmentHeaderText;
  final Color? signUpGetDepartmentChoiceText;
  final Color? signUpGetDepartmentDivider;
  final Color? signUpGetPhotoButtonColor;
  final Color? signUpGetPhotoButtonText;
  final Color? signUpGetInterestsText;
  final Color? signUpGetInterestsChoiceText;
  final Color? signUpGetPasswordHeader;
  final Color? signUpGetPasswordBorder;
  final Color? signUpGetPasswordBackground;
  final Color? signUpGetPasswordText;
  // Sign Up Page Colors End

  const OwnThemeFields({
    Color? generalReturnColor,
    Color? loginButtonBackground,
    Color? loginButtonText,
    Color? loginButtonBorder,
    Color? loginDontHaveAccount,
    Color? loginSignUp,
    Color? loginMailBackground,
    Color? loginMailInputBorder,
    Color? loginMailText,
    Color? loginPasswordBackground,
    Color? loginPasswordInputBorder,
    Color? loginPasswordText,
    Color? loginCheckBoxActiveColor,
    Color? loginCheckBoxText,
    Color? loginAppNameColor,
    Color? signUpBottomScrollerText,
    Color? signUpBottomScrollerDots,
    Color? signUpBottomScrollerCurrentDot,
    Color? signUpWelcomerText,
    Color? signUpGetNameBorder,
    Color? signUpGetNameBackground,
    Color? signUpGetNameText,
    Color? signUpGetIDHeaderText,
    Color? signUpGetIDText,
    Color? signUpGetIDBorder,
    Color? signUpGetIDBackground,
    Color? signUpGetDepartmentBorder,
    Color? signUpGetDepartmentBackground,
    Color? signUpGetDepartmentHeaderText,
    Color? signUpGetDepartmentChoiceText,
    Color? signUpGetDepartmentDivider,
    Color? signUpGetPhotoButtonColor,
    Color? signUpGetPhotoButtonText,
    Color? signUpGetInterestsText,
    Color? signUpGetInterestsChoiceText,
    Color? signUpGetPasswordHeader,
    Color? signUpGetPasswordBorder,
    Color? signUpGetPasswordBackground,
    Color? signUpGetPasswordText,
  })  : this.generalReturnColor = generalReturnColor,
        this.loginButtonBackground = loginButtonBackground,
        this.loginButtonText = loginButtonText,
        this.loginButtonBorder = loginButtonBorder,
        this.loginDontHaveAccount = loginDontHaveAccount,
        this.loginSignUp = loginSignUp,
        this.loginMailBackground = loginMailBackground,
        this.loginMailInputBorder = loginMailInputBorder,
        this.loginMailText = loginMailText,
        this.loginPasswordInputBorder = loginPasswordInputBorder,
        this.loginPasswordText = loginPasswordText,
        this.loginPasswordBackground = loginPasswordBackground,
        this.loginCheckBoxActiveColor = loginCheckBoxActiveColor,
        this.loginCheckBoxText = loginCheckBoxText,
        this.loginAppNameColor = loginAppNameColor,
        this.signUpBottomScrollerText = signUpBottomScrollerText,
        this.signUpBottomScrollerDots = signUpBottomScrollerDots,
        this.signUpBottomScrollerCurrentDot = signUpBottomScrollerCurrentDot,
        this.signUpWelcomerText = signUpWelcomerText,
        this.signUpGetNameBorder = signUpGetNameBorder,
        this.signUpGetNameText = signUpGetNameText,
        this.signUpGetNameBackground = signUpGetNameBackground,
        this.signUpGetIDBackground = signUpGetIDBackground,
        this.signUpGetIDBorder = signUpGetIDBorder,
        this.signUpGetIDHeaderText = signUpGetIDHeaderText,
        this.signUpGetIDText = signUpGetIDText,
        this.signUpGetDepartmentBorder = signUpGetDepartmentBorder,
        this.signUpGetDepartmentBackground = signUpGetDepartmentBackground,
        this.signUpGetDepartmentHeaderText = signUpGetDepartmentHeaderText,
        this.signUpGetDepartmentChoiceText = signUpGetDepartmentChoiceText,
        this.signUpGetDepartmentDivider = signUpGetDepartmentDivider,
        this.signUpGetPhotoButtonColor = signUpGetPhotoButtonColor,
        this.signUpGetPhotoButtonText = signUpGetPhotoButtonText,
        this.signUpGetInterestsChoiceText = signUpGetInterestsChoiceText,
        this.signUpGetInterestsText = signUpGetInterestsText,
        this.signUpGetPasswordBackground = signUpGetPasswordBackground,
        this.signUpGetPasswordBorder = signUpGetPasswordBorder,
        this.signUpGetPasswordHeader = signUpGetPasswordHeader,
        this.signUpGetPasswordText = signUpGetPasswordText;

  factory OwnThemeFields.empty() {
    return OwnThemeFields(
        loginButtonBackground: Colors.black,
        loginButtonText: Colors.black,
        loginButtonBorder: Colors.black,
        loginDontHaveAccount: Colors.black,
        loginSignUp: Colors.black);
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
