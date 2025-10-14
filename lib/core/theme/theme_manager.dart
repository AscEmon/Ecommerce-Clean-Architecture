import 'package:flutter/material.dart';
import '/core/constants/app_constants.dart';
import '/core/theme/theme_helper.dart';

import '../utils/preferences_helper.dart';

class ThemeManager {
  final String _themeKey = AppConstants.isDarkMode.key;
  bool _isDarkMode = false;
  static final ThemeManager _instance = ThemeManager._internal();

  factory ThemeManager() => _instance;

  ThemeManager._internal() {
    _loadThemePreference();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData =>
      _isDarkMode ? AppTheme.darkTheme() : AppTheme.lightTheme();

  /// Load saved theme preference
  Future<void> _loadThemePreference() async {
    try {
      _isDarkMode = PrefHelper.instance.getBool(_themeKey);
      // notifyListeners();
    } catch (e) {
      // Default to light theme if there's an error
      _isDarkMode = false;
    }
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;

    try {
      await PrefHelper.instance.setBool(_themeKey, _isDarkMode);
    } catch (e) {
      // Revert if saving fails
      _isDarkMode = !_isDarkMode;
    }
    await WidgetsBinding.instance.performReassemble();
  }
}

