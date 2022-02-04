import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static Map themesStrings = {
    ThemeMode.dark: 'dark',
    ThemeMode.light: 'light',
    ThemeMode.system: 'system',
  };

  static Map themeModes = {
    'dark': ThemeMode.dark,
    'light': ThemeMode.light,
    'system': ThemeMode.system,
  };

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static double getSizeFactor() {
    return _prefsInstance?.getDouble('sizeFactor') ?? 1.0;
  }

  static Future<bool> setSizeFactor(double sizeFactor) async {
    var prefs = await _instance;
    return prefs.setDouble('sizeFactor', sizeFactor);
  }

  static ThemeMode getTheme() {
    String name = _prefsInstance?.getString('theme') ?? 'system';

    return themeModes[name];
  }

  static Future<bool> setTheme(ThemeMode mode) async {
    var prefs = await _instance;
    return prefs.setString('theme', themesStrings[mode]);
  }

  static Future<bool> setLanguage(String languageCode) async {
    var prefs = await _instance;
    return prefs.setString('language', languageCode);
  }

  static String? getLanguage() {
    return _prefsInstance?.getString('language');
  }
}
