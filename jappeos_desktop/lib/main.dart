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

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shade_theming/shade_theming.dart';

import 'desktop/desktop.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ShadeTheme.setThemeProperties(_Themes.dtp, _Themes.ltp);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ShadeThemeProvider>(create: (_) => ShadeThemeProvider())
      ],
      child: const JappeOsDesktop(),
    ),
  );
}

/// This is the main class of the JappeOS Desktop, you may not access it.
///
/// (2020 - 2022)
class JappeOsDesktop extends StatelessWidget {
  const JappeOsDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'jappeos_desktop',
      debugShowCheckedModeBanner: false,
      home: Desktop(),
    );
  }
}

/// A private class that contains the dark and light theme data.
class _Themes {
  static DarkThemeProperties dtp = DarkThemeProperties(ThemeProperties(
      const Color.fromARGB(255, 30, 30, 30),
      const Color.fromARGB(255, 37, 37, 38),
      const Color.fromARGB(80, 243, 243, 243),
      Colors.blue,
      const Color(0xFFFFFFFF).withOpacity(0.9),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF).withOpacity(0.6),
      const Color(0xFF000000).withOpacity(0.9)));
  static LightThemeProperties ltp = LightThemeProperties(ThemeProperties(
      const Color.fromARGB(255, 255, 255, 255),
      const Color.fromARGB(255, 243, 243, 243),
      const Color.fromARGB(80, 37, 37, 38),
      Colors.blue,
      const Color(0xFF000000).withOpacity(0.9),
      const Color(0xFF000000),
      const Color(0xFF000000).withOpacity(0.6),
      const Color(0xFFFFFFFF).withOpacity(0.9)));
}