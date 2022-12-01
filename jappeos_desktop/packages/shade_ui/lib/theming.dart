//  ShadeUI, An UI elements package for JappeOS apps.
//  Copyright (C) 2022  Jappe02
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Affero General Public License as
//  published by the Free Software Foundation, either version 3 of the
//  License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Affero General Public License for more details.
//
//  You should have received a copy of the GNU Affero General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'dart:developer';

import 'package:shade_ui/main.dart';

/// Get/Set the current theme settings. Currently supports light and dark theme only.
class CurrentTheme {
  static DarkThemeProperties? _darkThemeProperties;
  static LightThemeProperties? _lightThemeProperties;

  static int _currentTheme = 0;

  // PUBLIC
  /// This method is already done after using the [ShadeUI.init] method.
  static void setThemeProperties(DarkThemeProperties dtp, LightThemeProperties ltp) {
    _darkThemeProperties = dtp;
    _lightThemeProperties = ltp;
  }

  /// Set the theme to dark (1) or light (0).
  static void setTheme(int theme) {
    if (theme == 0 || theme == 1) {
      _currentTheme = theme;
    } else {
      _currentTheme = 0;
    }
  }

  /// Get the current theme (1 = dark & 0 = light).
  static int getTheme() {
    return _currentTheme;
  }

  /// Get [ThemeProperties] for the light theme.
  static LightThemeProperties? getLightThemeProperties() {
    if (_isValidThemeProperty()) {
      return _lightThemeProperties;
    } else {
      log("Cannot get light theme properties because it returned null.");
    }
    return null;
  }

  /// Get [ThemeProperties] for the dark theme.
  static DarkThemeProperties? getDarkThemeProperties() {
    if (_isValidThemeProperty()) {
      return _darkThemeProperties;
    } else {
      log("Cannot get dark theme properties because it returned null.");
    }
    return null;
  }

  /// Get the current theme's properties (RECOMMENDED).
  static ThemeProperties getCurrentThemeProperties() {
    switch (_currentTheme) {
      case 0:
        {
          return _lightThemeProperties!.themeProperties;
        }
      case 1: 
        {
          return _darkThemeProperties!.themeProperties;
        }
    }
    return _lightThemeProperties!.themeProperties;
  }

  // PRIVATE
  static bool _isValidThemeProperty() {
    return _darkThemeProperties != null && _lightThemeProperties != null;
  }
}
