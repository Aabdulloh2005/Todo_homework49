import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static late SharedPreferences _prefs;

  static ThemeMode themeMode = ThemeMode.light;
  static String imageUrl = "";
  static double textSize = 14;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    themeMode = _prefs.getBool('themeMode') == true ? ThemeMode.dark : ThemeMode.light;
    imageUrl = _prefs.getString('imageUrl') ?? '';
    textSize = _prefs.getDouble('textSize') ?? 14;
  }

  static Future setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    await _prefs.setBool('themeMode', mode == ThemeMode.dark);
  }

  static Future setImageUrl(String url) async {
    imageUrl = url;
    await _prefs.setString('imageUrl', url);
  }

  static Future setTextSize(double size) async {
    textSize = size;
    await _prefs.setDouble('textSize', size);
  }
}
