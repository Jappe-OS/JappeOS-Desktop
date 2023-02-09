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

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jappeos_desktop/windowManager/windowTypes/wm_window_general.dart';
import 'wmresizablewindow.dart';

/// This class can be used to spawn a new window.
class WmController {
  WmController(this._onUpdate);

  // Resizable window.
  final List<Window> _resizablewindows = List.empty(growable: true);
  List<Window> get resizablewindows => _resizablewindows;

  final VoidCallback _onUpdate;

  // Jappeos window spawner
  /// Spawns a new JappeOS window and displays it on the screen.
  void wm$spawnGuiWindow(WMWindowType type) {
    _createNewWindow(type);
  }

  void _createNewWindow(WMWindowType type) {
    Window resizableWindow = Window(type);

    // Set initial position.
    Random rng = Random();
    resizableWindow.x = rng.nextDouble() * 500;
    resizableWindow.y = rng.nextDouble() * 500;

    // Init onWindowDragged.
    resizableWindow.onWindowDragged = (dx, dy) {
      resizableWindow.x += dx;
      resizableWindow.y += dy;

      // Put on top of stack. TODO: ISSUE
      _resizablewindows.remove(resizableWindow);
      _resizablewindows.add(resizableWindow);

      _onUpdate();
    };

    // Init onCloseButtonClicked.
    resizableWindow.onCloseButtonClicked = () {
      _resizablewindows.remove(resizableWindow);
      _onUpdate();
    };

    // Add Window to List.
    _resizablewindows.add(resizableWindow);

    // Update Widgets after adding the new window.
    _onUpdate();
  }
}
