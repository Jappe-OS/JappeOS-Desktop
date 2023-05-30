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
import 'wmwindow.dart';

/// This class can be used to spawn a new window.
class WmController {
  WmController(this._onUpdate);

  // Resizable window.
  final List<Window> _windows = List.empty(growable: true);
  List<Window> get windows => _windows;

  final VoidCallback _onUpdate;

  // Jappeos window spawner
  /// Spawns a new JappeOS window and displays it on the screen.
  void wm$spawnGuiWindow(WMWindowType type) {
    _createNewWindow(type);
  }

  void _createNewWindow(WMWindowType type) {
    Window window = Window(type);

    // Set initial position.
    Random rng = Random();
    window.setPos(rng.nextDouble() * 500, rng.nextDouble() * 500);

    // Init onSendToTop.
    window.onSendToTop = () {
      if (window.cancelSendToTop) {
        window.cancelSendToTop = false;
        return;
      }

      // Put on top of stack.
      _windows.remove(window);
      _windows.add(window);

      _onUpdate();
    };

    // Init onWindowDragged.
    window.onWindowDragged = (dx, dy) {
      window.setPos(window.getPos().dx + dx, window.getPos().dy + dy);
      window.onWindowDraggedEvent.broadcast(WindowDragEventArgs(dx, dy)); // <- TODO Fix window position event not working!

      window.onSendToTop!();

      _onUpdate();
    };

    // Init onCloseButtonClicked.
    window.onCloseButtonClicked = () {
      window.onWindowClosedEvent.broadcast();
      _windows.remove(window);
      _onUpdate();
    };

    // Add Window to List.
    _windows.add(window);

    // Update Widgets after adding the new window.
    _onUpdate();
  }
}
