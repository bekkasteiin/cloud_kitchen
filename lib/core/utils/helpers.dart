// ignore_for_file: unnecessary_string_interpolations

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('$key').toString();
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token').toString();
  }

  static Future<String> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userID').toString();
  }

  static Future<String> getUserAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('address').toString();
  }
}
