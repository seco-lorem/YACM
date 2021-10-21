import 'package:flutter/material.dart';

abstract class Language {
  static Language? of(BuildContext context) {
    return Localizations.of<Language>(context, Language);
  }

  // Login Page Strings
  String get loginPageLogin;
  String get loginPageSignUp;
  String get loginPageRememberMe;
  String get loginPageForgotPassword;
  String get loginPageDontHaveAccount;
  String get loginPagePassword;
  String get loginPageMail;

  // Sign Up Page String
  String get signUpBack;
  String get signUpNext;
  String get signUpFinish;
  String get signUpWelcomer;
}
