import 'package:flutter/material.dart';
import 'package:peedify/themes/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  ThemeData get theme =>
      _themeMode == ThemeMode.light ? AppTheme.lightTheme : AppTheme.darkTheme;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
