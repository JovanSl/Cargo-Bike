import 'package:flutter/material.dart';

import 'settings_service.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);
  final SettingsService _settingsService;
  late Locale _locale;
  late ThemeMode _themeMode;
  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _locale = await _settingsService.locale();
    notifyListeners();
  }

  Future<void> updateLocale(String langCode) async {
    _locale = Locale(langCode);
    await _settingsService.updateLocale(langCode);
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
    await _settingsService.updateThemeMode(newThemeMode);
  }
}
