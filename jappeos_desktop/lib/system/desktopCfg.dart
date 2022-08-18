//  JappeOS-Desktop, The desktop environment for JappeOS.
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

import 'package:flutter/material.dart';
import 'package:jappeos_desktop/main.dart';
import 'package:provider/provider.dart';

/// This class is used for configuring the desktop environment, the settings app may use this information and change it at any time.
/// Use the [DESKTOPCFG_INSTANCE] object to use it.
///
/// NOTE: `themeProvider.isDarkMode` should be used to know the theme of the UI (dark or light).
///
/// Made by Jappe. (2022)
class DesktopCfg {
  /// This is the instance for the DesktopCfg class, use this to access all the variables it contains.
  ///
  /// Made by Jappe. (2022)
  static DesktopCfg DESKTOPCFG_INSTANCE = new DesktopCfg();

  // --- [de-info]

  /// Get the name of the desktop.
  ///
  /// Made by Jappe. (2022)
  final String de_NAME = "jappe-os desktop";

  /// Get the version of the desktop.
  ///
  /// Made by Jappe. (2022)
  final String de_VERSION = "alpha: 1.1.3";

  // --- [theme stuff]

  // BG = Background

  /// Get whether the UI is in dark mode or not. [color theme]
  ///
  /// Made by Jappe. (2022)
  bool isDarkMode(BuildContext context) {
    late final themeProvider = Provider.of<ThemeProvider>(context);

    return themeProvider.isDarkMode;
  }

  /// Set the UI to dark or light mode. [color theme]
  ///
  /// Made by Jappe. (2022)
  void setDarkMode(BuildContext context, bool darkMode) {
    late final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    themeProvider.toggleTheme(darkMode);
  }

  /// Get the theme provider instead of using it directly from `main.dart` [color theme]
  ///
  /// Made by Jappe. (2022)
  ThemeProvider getThemeProvider(BuildContext context) {
    return Provider.of<ThemeProvider>(context);
  }

  /// Get the theme provider instead of using it directly from `main.dart` [color theme]
  ///
  /// Made by Jappe. (2022)
  ThemeProvider getThemeProviderL(BuildContext context, bool listen) {
    return Provider.of<ThemeProvider>(context, listen: listen);
  }

  /// The blur color for the dark theme of the desktop. [blur colors]
  ///
  /// Made by Jappe. (2022)
  final Color dsktp_BLUR_COLOR_DARK = Color.fromARGB(255, 10, 10, 10).withOpacity(0.4);

  /// The blur color for the light theme of the desktop. [blur colors]
  ///
  /// Made by Jappe. (2022)
  final Color dsktp_BLUR_COLOR_LIGHT = Color.fromARGB(255, 245, 245, 245).withOpacity(0.4);

  /// The background blur color for the dark theme of the desktop. [blur color background]
  ///
  /// Made by Jappe. (2022)
  final Color dsktp_BLUR_COLOR_DARK_BG = Color.fromARGB(255, 27, 27, 27).withOpacity(0.4);

  /// The background blur color for the light theme of the desktop. [blur color background]
  ///
  /// Made by Jappe. (2022)
  final Color dsktp_BLUR_COLOR_LIGHT_BG = Color.fromARGB(255, 228, 228, 228).withOpacity(0.4);

  /// The background color for the dark theme of the desktop. (no blur) [background color]
  ///
  /// Made by Jappe. (2022)
  final Color dsktp_BG_COLOR_DARK = Color.fromARGB(255, 30, 30, 30);

  /// The background color for the light theme of the desktop. (no blur) [background color]
  ///
  /// Made by Jappe. (2022)
  final Color dsktp_BG_COLOR_LIGHT = Color.fromARGB(255, 255, 255, 255);

  /// The secondary background color for the dark theme of the desktop. (no blur) [secondary background color]
  ///
  /// Made by Jappe. (2022)
  final Color dsktp_BG_COLOR_DARK_SECONDARY = Color.fromARGB(255, 37, 37, 38);

  /// The secondary background color for the light theme of the desktop. (no blur) [secondary background color]
  ///
  /// Made by Jappe. (2022)
  final Color dsktp_BG_COLOR_LIGHT_SECONDARY = Color.fromARGB(255, 243, 243, 243);

  /// The background blur color for the dark theme of the desktop. [border color]
  ///
  /// Made by Jappe. (2022)
  final Color dsktp_BORDER_COLOR_DARK = Color.fromARGB(80, 243, 243, 243);

  /// The background blur color for the light theme of the desktop. [border color]
  ///
  /// Made by Jappe. (2022)
  final Color dsktp_BORDER_COLOR_LIGHT = Color.fromARGB(80, 37, 37, 38);

  /// The normal text color for the light theme of the desktop. [text color]
  ///
  /// Made by Jappe. (2022)
  final dsktp_TEXT_COLOR_LIGHT = Color(0xFF000000);

  /// The normal text color for the dark theme of the desktop. [text color]
  ///
  /// Made by Jappe. (2022)
  final dsktp_TEXT_COLOR_DARK = Color(0xFFFFFFFF);

  /// The secondary text color for the light theme of the desktop. [text color]
  ///
  /// Made by Jappe. (2022)
  final dsktp_TEXT_COLOR_LIGHT_SECONDARY = Color(0xFF000000).withOpacity(0.5);

  /// The secondary text color for the dark theme of the desktop. [text color]
  ///
  /// Made by Jappe. (2022)
  final dsktp_TEXT_COLOR_DARK_SECONDARY = Color(0xFFFFFFFF).withOpacity(0.5);

  /// The normal icon color for the light theme of the desktop. [icon color]
  ///
  /// Made by Jappe. (2022)
  final dsktp_ICON_COLOR_LIGHT = Colors.black.withOpacity(0.7);

  /// The normal icon color for the dark theme of the desktop. [icon color]
  ///
  /// Made by Jappe. (2022)
  final dsktp_ICON_COLOR_DARK = Colors.white.withOpacity(0.7);

  /// Sets the accent color of the UI. [accent color]
  ///
  /// Made by Jappe. (2022)
  void setJappeOsAccentColor(BuildContext context, JappeOsColor arg0) {
    late final accentColorProvider = Provider.of<ThemeProvider>(context, listen: false);

    accentColorProvider.setJappeOsColor(arg0);
  }

  /// Gets the accent color of the UI. [accent color]
  ///
  /// Made by Jappe. (2022)
  JappeOsColor getJappeOsAccentColor(BuildContext context) {
    late final accentColorProvider = Provider.of<ThemeProvider>(context);

    return accentColorProvider.getJappeOsColor;
  }

  /// Get the CURRENT accent color as a `Color` [accent color]
  ///
  /// Made by Jappe. (2022)
  Color getCurrentJappeOsAccentColorAsColor(BuildContext context) {
    late final accentColorProvider = Provider.of<ThemeProvider>(context);

    switch (accentColorProvider.getJappeOsColor) {
      case JappeOsColor.BLUE:
        {
          return Colors.blueAccent;
        }
      case JappeOsColor.YELLOW:
        {
          return Colors.yellowAccent;
        }
      case JappeOsColor.GREEN:
        {
          return Colors.greenAccent;
        }
      case JappeOsColor.RED:
        {
          return Colors.redAccent;
        }
      case JappeOsColor.DEFAULT:
        {
          return Colors.blueAccent;
        }
    }
  }

  /// Get the accent color as a `Color?` [accent color]
  ///
  /// Made by Jappe. (2022)
  Color? getJappeOsAccentColorAsColor(JappeOsColor arg0) {
    switch (arg0) {
      case JappeOsColor.BLUE:
        {
          return Colors.blueAccent;
        }
      case JappeOsColor.YELLOW:
        {
          return Colors.yellowAccent;
        }
      case JappeOsColor.GREEN:
        {
          return Colors.greenAccent;
        }
      case JappeOsColor.RED:
        {
          return Colors.redAccent;
        }
      case JappeOsColor.DEFAULT:
        {
          return Colors.blueAccent;
        }
    }
  }

  /// This is the wallpaper of the desktop.
  ///
  /// Made by Jappe. (2022)
  final String dsktpWallpaper =
      "lib/images/desktop/backgrounds/wallpaper2.jpg"; // This should get the picture from a local folder in the future or something.

}

/// This is just an `enum` for all the custom colors for JappeOS Desktop UI.
///
/// Made by Jappe. (2022)
enum JappeOsColor { DEFAULT, BLUE, YELLOW, GREEN, RED }
