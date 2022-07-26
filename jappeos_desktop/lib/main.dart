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
import 'package:jappeos_desktop/system/desktopCfg.dart';
import 'desktop.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(JappeOsDesktop());
}

/// This is the main class of the JappeOS Desktop, you may not access it.
/// 
/// Made by Jappe. (2020 - 2022)
class JappeOsDesktop extends StatelessWidget {

  // Whether the theme is light or dark.
  final bool _isLight = DesktopCfg.DESKTOPCFG_INSTANCE.getColorMode() == ColorMode.LIGHT ? true : false;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jappeos_desktop',
      debugShowCheckedModeBanner: false,
      theme: _isLight ? _lightTheme : _darkTheme,
      home: Desktop(),
    );
  }

  // ThemeData for light theme.
  final ThemeData _lightTheme = ThemeData(
    visualDensity: VisualDensity.standard,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: DesktopCfg.DESKTOPCFG_INSTANCE.getJappeosThemeColor(JappeOsColor.DEFAULT), brightness: Brightness.light),
    
  );

  // ThemeData for dark theme.
  final ThemeData _darkTheme = ThemeData(
    visualDensity: VisualDensity.standard,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: DesktopCfg.DESKTOPCFG_INSTANCE.getJappeosThemeColor(JappeOsColor.DEFAULT), brightness: Brightness.dark),
    
  );
}
