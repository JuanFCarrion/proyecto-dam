import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/config/theme.dart';
import 'package:proyecto_dam/src/utils/storage_manager.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _themeData = AppThemeData.lightTheme;
  ThemeData getTheme() => _themeData;

  ThemeProvider() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = AppThemeData.lightTheme;
      } else {
        _themeData = AppThemeData.darkTheme;
      }
      notifyListeners();
    }).catchError((onError) {
      _themeData = AppThemeData.lightTheme;
    });
  }

  void setDarkMode() async {
    _themeData = AppThemeData.darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = AppThemeData.lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
