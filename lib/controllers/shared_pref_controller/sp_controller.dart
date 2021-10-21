import 'package:shared_preferences/shared_preferences.dart';

/// This class is a controller for events done with SharedPreferences package.
/// To access methods, use static class instance
///
/// Example;
/// bool exists = await SPController.getBoolValue();
class SPController {
  SPController();

  static Future<bool?> getBoolValue(String key) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      return sp.getBool(key);
    } catch (error) {
      throw Exception("Could not get bool value.\nError: ${error.toString()}");
    }
  }

  static Future<String?> getStringValue(String key) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      return sp.getString(key);
    } catch (error) {
      throw Exception("Could not get string.\nError: ${error.toString()}");
    }
  }

  static Future<List<String>?> getStringListValue(String key) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      return sp.getStringList(key);
    } catch (error) {
      throw Exception("Could not get string list.\nError: ${error.toString()}");
    }
  }

  static Future<int?> getIntValue(String key) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      return sp.getInt(key);
    } catch (error) {
      throw Exception("Could not get int.\nError: ${error.toString()}");
    }
  }

  static Future<double?> getDoubleValue(String key) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      return sp.getDouble(key);
    } catch (error) {
      throw Exception("Could not get double.\nError: ${error.toString()}");
    }
  }

  static Future<Set<String>?> getKeys() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      return sp.getKeys();
    } catch (error) {
      throw Exception("Could not get keys.\nError: ${error.toString()}");
    }
  }

  static Future<bool> setBoolValue(String key, bool value) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setBool(key, value);
      return true;
    } catch (error) {
      throw Exception("Could not put bool value.\nError: ${error.toString()}");
    }
  }

  static Future<bool> setStringValue(String key, String value) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(key, value);
      return true;
    } catch (error) {
      throw Exception("Could not put string.\nError: ${error.toString()}");
    }
  }

  static Future<bool> setStringListValue(String key, List<String> value) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setStringList(key, value);
      return true;
    } catch (error) {
      throw Exception("Could not put string list.\nError: ${error.toString()}");
    }
  }

  static Future<bool> setIntValue(String key, int value) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setInt(key, value);
      return true;
    } catch (error) {
      throw Exception("Could not put int.\nError: ${error.toString()}");
    }
  }

  static Future<bool> setDoubleValue(String key, double value) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setDouble(key, value);
      return true;
    } catch (error) {
      throw Exception("Could not put double.\nError: ${error.toString()}");
    }
  }
}
