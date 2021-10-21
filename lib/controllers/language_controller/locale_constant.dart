import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

const String prefSelectedLanguageCode = "SelectedLanguageCode";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _sf = await SharedPreferences.getInstance();
  await _sf.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _sf = await SharedPreferences.getInstance();
  String languageCode = _sf.getString(prefSelectedLanguageCode) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty ? Locale(languageCode, '') : Locale('en', '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  Locale _locale = await setLocale(selectedLanguageCode);
  MyApp.setLocale(context, _locale);
}
