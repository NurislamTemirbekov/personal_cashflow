import 'package:flutter/material.dart';
import 'theme_service.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  Future<void> loadTheme() async {
    final isDark = await ThemeService.isDarkMode();
    _isDarkMode = isDark;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await ThemeService.setDarkMode(_isDarkMode);
    notifyListeners();
  }

  Future<void> setTheme(bool isDark) async {
    _isDarkMode = isDark;
    await ThemeService.setDarkMode(_isDarkMode);
    notifyListeners();
  }
}

