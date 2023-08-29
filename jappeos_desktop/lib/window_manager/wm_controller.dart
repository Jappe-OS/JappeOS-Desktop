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

part of window_manager;

/// This class can be used to spawn a new window.
class WmController {
  WmController(this._onUpdate);

  // Resizable window.
  final List<Window> _windows = List.empty(growable: true);
  List<Window> get windows => _windows;

  final VoidCallback _onUpdate;

  // Jappeos window spawner
  /// Spawns a new JappeOS window and displays it on the screen.
  Window wm$spawnGuiWindow(WMWindowType type) {
    return _createNewWindow(type);
  }

  Window _createNewWindow(WMWindowType type) {
    Window window = Window(type);

    // Init onSendToTop.
    window.onSendToTop = () {
      if (window.cancelSendToTop) {
        window.cancelSendToTop = false;
        return;
      }

      // Put on top of stack.
      _windows.remove(window);
      _windows.add(window);

      window.isActive = true;
      int index = _windows.length - 2;
      if (index >= 0 && index < _windows.length) _windows[index].isActive = false;

      _onUpdate();
    };

    // Init onWindowDragged.
    window.onWindowDragged = (dx, dy) {
      if (MOBILE_MODE) return;

      window.setPos(window.getPos().dx + dx, window.getPos().dy + dy);
      window.onWindowDraggedEvent.broadcast(WindowDragEventArgs(dx, dy));

      window.onSendToTop!();

      _onUpdate();
    };

    // Init onCloseButtonClicked.
    window.onCloseButtonClicked = () {
      window.onWindowClosedEvent.broadcast();
      _windows.remove(window);
      _onUpdate();
    };

    // Set initial position for desktop mode.
    if (!MOBILE_MODE) {
      Random rng = Random();
      window.setPos(rng.nextDouble() * 500, rng.nextDouble() * 500);
    }

    // Add Window to List.
    _windows.add(window);
    window.onSendToTop!();

    // Update Widgets after adding the new window.
    _onUpdate();

    return window;
  }
}
