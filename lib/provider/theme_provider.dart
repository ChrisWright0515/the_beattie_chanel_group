import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;
  static const String _themePreferenceKey = 'theme_preference';

  ThemeProvider() : _themeData = lightTheme {
    // Set initial theme to dark
    _loadTheme();
  }

  ThemeData get themeData => _themeData;

  void setTheme(ThemeData theme) {
    _themeData = theme;
    _saveTheme(theme == darkTheme);
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightTheme) {
      setTheme(darkTheme);
    } else {
      setTheme(lightTheme);
    }
  }

  void _saveTheme(bool isDarkTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themePreferenceKey, isDarkTheme);
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkTheme =
        prefs.getBool(_themePreferenceKey) ?? false; // Default to dark theme
    _themeData = isDarkTheme ? darkTheme : lightTheme;
    notifyListeners();
  }

  bool isDarkTheme() {
    return _themeData == darkTheme;
  }

  Color oppositeBackgroundColor() {
    return isDarkTheme() ? lightBackground : darkBackground;
  }

  Color oppositeTextColor() {
    return isDarkTheme() ? lightText : darkText;
  }
}
