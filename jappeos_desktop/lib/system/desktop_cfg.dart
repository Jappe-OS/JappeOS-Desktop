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
import 'package:provider/provider.dart';

/// This class is the ThemeProvider. Methods called in this class are instantly updated in this app.
//class ThemeProvider extends ChangeNotifier {
//  ThemeMode themeMode = ThemeMode.light;
//
//  bool get isDarkMode {
//    if (themeMode == ThemeMode.system) {
//      final brightness = SchedulerBinding.instance.window.platformBrightness;
//      Logger.GET.jappeOsLogger$sendLog(
//          JappeOsLoggerMsgType.error, false, "'themeMode', typeof ThemeMode returned ThemeMode.system, this is not supported!");
//      return brightness == Brightness.dark;
//    } else {
//      return themeMode == ThemeMode.dark;
//    }
//  }
//
//  void toggleTheme(bool isOn) {
//    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
//    notifyListeners();
//  }
//
//  // --
//
//  JappeOsColor jappeOsColor = JappeOsColor.defaul$;
//
//  JappeOsColor get getJappeOsColor {
//    return jappeOsColor;
//  }
//
//  void setJappeOsColor(JappeOsColor color) {
//    jappeOsColor = color;
//    notifyListeners();
//  }
//}

/// Get(/set) theme (dark/light) or switch between them.
class DesktopCfg$ThemeManager extends ChangeNotifier {
  /// Get the current theme using [ThemeMode]. See: [isDarkMode].
  ThemeMode getThemeMode() {
    return isDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  /// Get the current theme (light/dark).
  bool isDarkMode() {
    return false;
  }

  /// Set the theme, setting will apply instantly (light/dark).
  void setDarkMode(bool darkMode) {}

  // -+-+-+-+-+-+-+-+-+

  // ThemeData for light theme.
  static ThemeData lightTheme(BuildContext context) {
    final themeColorGettersProvider = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: themeColorGettersProvider.getCurrentAccentColor()).copyWith(brightness: Brightness.light),
    );
  }

  // ThemeData for dark theme.
  static ThemeData darkTheme(BuildContext context) {
    final themeColorGettersProvider = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: themeColorGettersProvider.getCurrentAccentColor()).copyWith(brightness: Brightness.dark),
    );
  }
}

/// Get different colors of the UI and use them in your widgets.
class DesktopCfg$ThemeColorGetters extends ChangeNotifier {
  Color getBackgroundColor(BuildContext context, DesktopCfg$BackgroundColorType arg0) {
    switch (arg0) {
      case DesktopCfg$BackgroundColorType.normal:
        return Provider.of<DesktopCfg$ThemeManager>(context).isDarkMode() ? const Color.fromARGB(255, 30, 30, 30) : const Color.fromARGB(255, 255, 255, 255);
      case DesktopCfg$BackgroundColorType.brighter:
        return Provider.of<DesktopCfg$ThemeManager>(context).isDarkMode() ? const Color.fromARGB(255, 37, 37, 38) : const Color.fromARGB(255, 243, 243, 243);
    }
  }

  Color getBorderColor(BuildContext context) {
    return Provider.of<DesktopCfg$ThemeManager>(context).isDarkMode()
        ? const Color.fromARGB(80, 243, 243, 243)
        : const Color.fromARGB(80, 37, 37, 38);
  }

  Color getTextColor(BuildContext context, DesktopCfg$TextColorType arg0) {
    switch (arg0) {
      case DesktopCfg$TextColorType.title:
        return Provider.of<DesktopCfg$ThemeManager>(context).isDarkMode() ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
      case DesktopCfg$TextColorType.normal:
        return Provider.of<DesktopCfg$ThemeManager>(context).isDarkMode()
            ? const Color(0xFFFFFFFF).withOpacity(0.9)
            : const Color(0xFF000000).withOpacity(0.9);
      case DesktopCfg$TextColorType.small:
        return Provider.of<DesktopCfg$ThemeManager>(context).isDarkMode()
            ? const Color(0xFFFFFFFF).withOpacity(0.6)
            : const Color(0xFF000000).withOpacity(0.6);
    }
  }

  MaterialColor getCurrentAccentColor() {
    return Colors.blue;
  }
}

/// Set different colors of the UI and the settings will be updated instantly.
/// This will not contain any theme-driven properties, if you want to change the
/// theme, use [DesktopCfg$ThemeManager.setDarkMode].
class DesktopCfg$ThemeColorSetters extends ChangeNotifier {
  static void setCurrentAccentColor() {}
}

/// The type of the background color.
enum DesktopCfg$BackgroundColorType { normal, brighter }

/// The type of the text color. Custom colors can be used if visible on both themes (dark/light) (not white/black).
enum DesktopCfg$TextColorType { title, normal, small }
