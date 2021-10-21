import 'package:flutter/material.dart';
import '../../models/language/language.dart';
import '../../models/language/languages/English.dart';
import '../../models/language/languages/Turkish.dart';

class LanguageDelegate extends LocalizationsDelegate<Language> {
  const LanguageDelegate();

  static const List<String> languages = const ['tr', 'en'];

  static const List<String> languagesExpanded = const ["Türkçe", "English"];

  @override
  bool isSupported(Locale locale) => languages.contains(locale.languageCode);

  @override
  Future<Language> load(Locale locale) => _load(locale);

  static Future<Language> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'tr':
        return Turkish();
      case 'en':
        return English();
      default:
        return English();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Language> old) => false;
}
