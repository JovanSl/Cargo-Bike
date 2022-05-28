import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    int? theme = 1;
    final prefs = await SharedPreferences.getInstance();
    theme = prefs.getInt('theme');
    if (theme == 1) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  Future<Locale> locale() async {
    final prefs = await SharedPreferences.getInstance();

    return Locale(prefs.getString('lang') ?? 'en');
  }

  Future<void> updateLocale(String langCode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('lang', langCode);
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('theme', theme.index);
  }
}
