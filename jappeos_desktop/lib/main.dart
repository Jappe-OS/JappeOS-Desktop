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
import 'package:flutter/scheduler.dart';
import 'package:jappeos_desktop/system/desktopCfg.dart';
import 'package:jappeos_desktop/system/logger/logType.dart';
import 'package:jappeos_desktop/system/logger/logger.dart';
import 'desktop.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(JappeOsDesktop());
}

/// This is the main class of the JappeOS Desktop, you may not access it.
///
/// Made by Jappe. (2020 - 2022)
class JappeOsDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => _ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<_ThemeProvider>(context);

          return MaterialApp(
            title: 'jappeos_desktop',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: _Themes.lightTheme,
            darkTheme: _Themes.darkTheme,
            home: Desktop(),
          );
        },
      );
}

// This class is the ThemeProvider.
class _ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode {
    if (themeMode != ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      Logger.GET.jappeOsLogger$sendLog(
          JappeOsLoggerMsgType.ERROR, false, "'themeMode', typeof ThemeMode returned ThemeMode.system, this is not supported!");
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

// This class contains the [ThemeData] for all themes.
class _Themes {
  // ThemeData for light theme.
  static final ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.standard,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: DesktopCfg.DESKTOPCFG_INSTANCE.getJappeosThemeColor(JappeOsColor.DEFAULT), brightness: Brightness.light),
  );

  // ThemeData for dark theme.
  static final ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.standard,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: DesktopCfg.DESKTOPCFG_INSTANCE.getJappeosThemeColor(JappeOsColor.DEFAULT), brightness: Brightness.dark),
  );
}
