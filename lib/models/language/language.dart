import 'package:flutter/material.dart';

abstract class Language {
  static Language? of(BuildContext context) {
    return Localizations.of<Language>(context, Language);
  }

  String get home;
  String get pinned;
  String get subscription;
  String get profile;
  String get explore;
  String get notifications;
  String get signOut;
  String get suggested;
  String get posts;
  String get chat;
  String get kickMembers;
  String get createPost;
  String get event;
  String get poll;
  String get publish;
  String get description;
  String get enableComments;
  String get option;
  String get typeQuestion;
  String get typeDescription;
  String get mute;
  String get sub;
  String get delete;
  String get veto;
  String get search;
  String get cancel;
  String get changePassword;
  String get newPassword;
  String get changeLanguage;
  String get changeTheme;
  String get typeHere;
  String get currentPassword;

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
