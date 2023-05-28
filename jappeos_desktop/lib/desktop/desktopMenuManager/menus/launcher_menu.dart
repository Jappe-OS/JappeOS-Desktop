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
import 'package:jappeos_desktop/desktop/desktop.dart';
import 'package:provider/provider.dart';
import 'package:shade_theming/shade_theming.dart';

import '../../../applications/settings/main.dart';
import '../../../system/appSystem/applications.dart';
import '../desktop_menu_controller.dart';

class LauncherMenu extends DesktopMenu {
  @override
  Widget getContents() {
    Color overlayColor = DesktopState.publicContext!.watch<ShadeThemeProvider>().getTheme() == 0
        ? const Color.fromRGBO(255, 255, 255, 0.3)
        : const Color.fromRGBO(0, 0, 0, 0.3);

    Widget controlButton(IconData icon, String tooltip, Function() onPress) {
      return IconButton(onPressed: onPress, icon: Icon(icon, color: DesktopState.publicContext!.watch<ShadeThemeProvider>().getCurrentThemeProperties().accentColor,), tooltip: tooltip, padding: const EdgeInsets.all(3),);
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextField(
              style: TextStyle(color: DesktopState.publicContext!.watch<ShadeThemeProvider>().getCurrentThemeProperties().normalTextColor),
              decoration: InputDecoration(
                hintText: "Search Files, Apps & More",
                hintStyle: TextStyle(
                    color: DesktopState.publicContext!.watch<ShadeThemeProvider>().getCurrentThemeProperties().normalTextColor.withOpacity(0.5)),
                filled: true,
                fillColor: overlayColor,
                border: const OutlineInputBorder(),
                isDense: true,
                contentPadding: const EdgeInsets.all(12),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.7, color: DesktopState.publicContext!.watch<ShadeThemeProvider>().getCurrentThemeProperties().borderColor),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.7, color: DesktopState.publicContext!.watch<ShadeThemeProvider>().getCurrentThemeProperties().accentColor),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Container(
            height: 400 - 17,
            margin: const EdgeInsets.only(bottom: 10),
          ),
          SizedBox(
            height: 40,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: overlayColor,
                ),
                height: 35,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    controlButton(Icons.power_settings_new, "Shut Down", () {}),
                    controlButton(Icons.nightlight, "Sleep", () {}),
                    controlButton(Icons.settings, "Settings", () {Applications.sys$runProcess(Settings());}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  DesktopMenuPosition getPos() {
    return DesktopMenuPosition.left;
  }

  @override
  Size getSize() {
    return const Size(500, 500);
  }
}
