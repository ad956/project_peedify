import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peedify/themes/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeData get theme =>
      _themeMode == ThemeMode.light ? AppTheme.lightTheme : AppTheme.darkTheme;

  ThemeData get lightTheme => AppTheme.lightTheme;

  ThemeData get darkTheme => AppTheme.darkTheme;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setSystemUIOverlayStyle(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final colorScheme = Theme.of(context).colorScheme;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          brightness == Brightness.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: colorScheme.surface,
      systemNavigationBarIconBrightness:
          brightness == Brightness.light ? Brightness.dark : Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}
