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
import 'dMenuUI.dart';

/// This class can be used to spawn a new desktop overlay menu.
class DesktopMenu$Controller {
  DesktopMenu$Controller(this._onUpdate);

  // Resizable window.
  final List<DesktopMenu$UI> _menuWindows = List.empty(growable: true);
  List<DesktopMenu$UI> get menuWindows => _menuWindows;

  final VoidCallback _onUpdate;

  /// Open a desktop overlay menu.
  void openDesktopOverlayMenu(BuildContext context, DesktopMenu$Menus menu) {
    switch (menu) {
      case DesktopMenu$Menus.launcher:
        _spawnMenu(DesktopOverlayMenus(DesktopMenu$Menus.launcher, uContext: context), 0, 30, 500, 500, true, Alignment.topLeft);
        break;
      case DesktopMenu$Menus.taskView:
        _spawnMenu(DesktopOverlayMenus(DesktopMenu$Menus.taskView, uContext: context), 10, 40, 500, 500, false, Alignment.topLeft);
        break;
      case DesktopMenu$Menus.quickSettings:
        _spawnMenu(DesktopOverlayMenus(DesktopMenu$Menus.quickSettings, uContext: context), 10, 40, 500, 500, false, Alignment.topLeft);
        break;
    }
  }

  /// Spawns a menu window on the desktop.
  void _spawnMenu(Widget body, double x, double y, double w, double h, bool fill, AlignmentGeometry align) {
    _createNewWindowedApp(body, x, y, w, h, fill, align);
  }

  void _createNewWindowedApp(Widget body, double x, double y, double w, double h, bool fill, AlignmentGeometry align) {
    DesktopMenu$UI desktopMenu = DesktopMenu$UI(body, x, y, w, h, fill, align);

    // Set the position of the menu window.
    desktopMenu.x = x;
    desktopMenu.y = y;

    // Set the size of the menu window.
    desktopMenu.w = w;
    desktopMenu.h = h;

    // Add Window to List.
    if (_menuWindows.isNotEmpty) {
      _menuWindows.clear();
    } else {
      _menuWindows.add(desktopMenu);
    }

    // Update widgets after adding the new menu window.
    _onUpdate();
  }
}

/// An `enum` that contains all the different desktop menus.
enum DesktopMenu$Menus { launcher, taskView, quickSettings }
