import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeServiceRepository {
  final String _hiveBoxName = 'themeService';
  late final Box _hiveBox;

  Future<ThemeServiceRepository> init() async {
    _hiveBox = await Hive.openBox(_hiveBoxName);
    return this;
  }

  Future<ThemeMode> getThemeMode() async {
    String res = _hiveBox.get('themeMode', defaultValue: 'system');
    switch (res) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
    }
    return ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    switch (themeMode) {
      case ThemeMode.system:
        await _hiveBox.put('themeMode', 'system');
        break;
      case ThemeMode.light:
        await _hiveBox.put('themeMode', 'light');
        break;
      case ThemeMode.dark:
        await _hiveBox.put('themeMode', 'dark');
        break;
    }
  }
}
