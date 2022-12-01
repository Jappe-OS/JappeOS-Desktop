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

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:shade_ui/theming.dart';

/// Properties for a theme.
class ThemeProperties {
  const ThemeProperties(this.backgroundColor1, this.backgroundColor2, this.borderColor, this.accentColor, this.normalTextColor, this.darkerTextColor,
      this.secondaryTextColor, this.invertedTextColor);

  final Color backgroundColor1;
  final Color backgroundColor2;

  final Color borderColor;

  final Color accentColor;

  final Color normalTextColor;
  final Color darkerTextColor;
  final Color secondaryTextColor;
  final Color invertedTextColor;
}

/// Properties for the dark theme.
class DarkThemeProperties {
  const DarkThemeProperties(this.themeProperties);

  final ThemeProperties themeProperties;
}

/// Properties for the light theme.
class LightThemeProperties {
  const LightThemeProperties(this.themeProperties);

  final ThemeProperties themeProperties;
}

/// The main class.
class ShadeUI {
  /// Initialize ShadeUI.
  void init(DarkThemeProperties dtp, LightThemeProperties ltp) {
    CurrentTheme.setThemeProperties(dtp, ltp);
  }
}
