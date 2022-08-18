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
///
/// Made by Jappe. (2022)
class DesktopMenu$Controller {
  DesktopMenu$Controller(this._onUpdate);

  // Resizable window.
  List<DesktopMenu$UI> _menuWindows = List.empty(growable: true);
  List<DesktopMenu$UI> get menuWindows => _menuWindows;

  VoidCallback _onUpdate;

  /// Open a desktop overlay menu.
  ///
  /// Made by Jappe. (2022)
  void openDesktopOverlayMenu(DesktopMenu$Menus menu) {
    switch (menu) {
      case DesktopMenu$Menus.Launcher:
        _spawnMenu(DesktopMenu$Menus.Launcher, DesktopOverlayMenus(DesktopMenu$Menus.Launcher), 10, 40, 500, 500);
        break;
      case DesktopMenu$Menus.TaskView:
        _spawnMenu(DesktopMenu$Menus.TaskView, DesktopOverlayMenus(DesktopMenu$Menus.TaskView), 10, 40, 500, 500);
        break;
      case DesktopMenu$Menus.QuickSettings:
        _spawnMenu(DesktopMenu$Menus.QuickSettings, DesktopOverlayMenus(DesktopMenu$Menus.QuickSettings), 10, 40, 500, 500);
        break;
    }
  }

  /// Spawns a menu window on the desktop.
  ///
  /// Made by Jappe. (2022)
  void _spawnMenu(DesktopMenu$Menus menu, Widget body, double x, double y, double w, double h) {
    _createNewWindowedApp(menu, body, x, y, w, h);
  }

  void _createNewWindowedApp(DesktopMenu$Menus menu, Widget body, double x, double y, double w, double h) {
    DesktopMenu$UI desktopMenu = DesktopMenu$UI(menu, body, x, y, w, h);

    // Set the position of the menu window.
    desktopMenu.x = x;
    desktopMenu.y = y;

    // Set the size of the menu window.
    desktopMenu.w = w;
    desktopMenu.h = h;

    // Add Window to List.
    if (_menuWindows.length > 0) {
      _menuWindows.clear();
    } else {
      _menuWindows.add(desktopMenu);
    }

    // Update widgets after adding the new menu window.
    _onUpdate();
  }
}

/// An `enum` that contains all the different desktop menus.
///
/// Made by Jappe. (2022)
enum DesktopMenu$Menus { Launcher, TaskView, QuickSettings }
