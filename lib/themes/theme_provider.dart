import 'package:flutter/material.dart';
import 'dark.dart';
import 'light.dart';

class ThemeProvider extends ChangeNotifier {
  // light mode to begin with

  ThemeData _themeData = lightMode;

  // get theme

  ThemeData get themeData => _themeData;

// dark mode?
  bool get isDarkMode => _themeData == darkMode;

// set theme

  set themeData(ThemeData themeData) {
    _themeData = themeData;

// update the UI
    notifyListeners();
  }

// toggle theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
