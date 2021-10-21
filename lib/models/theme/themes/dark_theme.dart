import 'package:flutter/material.dart';

import '../own_theme_fields.dart';

class DarkTheme {
  ThemeData _themeData = ThemeData()..addOwn(OwnThemeFields());

  DarkTheme();

  ThemeData getTheme() => _themeData;
}
