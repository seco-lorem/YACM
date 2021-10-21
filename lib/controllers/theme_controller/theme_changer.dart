import 'package:flutter/material.dart';
import '../../models/theme/themes/dark_theme.dart';
import '../../models/theme/themes/light_theme.dart';
import '../shared_pref_controller/sp_controller.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData? _themeData;

  ThemeChanger(bool dark) {
    if (dark) {
      _themeData = DarkTheme().getTheme();
    } else {
      _themeData = LightTheme().getTheme();
    }
  }

  ThemeData? getTheme() => _themeData;

  bool setTheme(bool dark) {
    try {
      if (dark) {
        _themeData = DarkTheme().getTheme();
      } else {
        _themeData = LightTheme().getTheme();
      }
      SPController.setBoolValue("darkTheme", dark);
      notifyListeners();
      return true;
    } catch (error) {
      throw Exception("Could not set theme.\nError ${error.toString()}");
    }
  }
}
