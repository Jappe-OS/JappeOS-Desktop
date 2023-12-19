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
class WindowStackController {
  WindowStackController(this._onUpdate);

  // List of windows.
  final List<Window> _windows = [];
  List<Window> get windows => _windows;

  final VoidCallback _onUpdate;

  Window createWindow() {
    /*TODO: Remove*/ print("Begin window creation.");
    Window window = Window();

    // Init onFocusChanged.
    void onFocusChangedEvent(WindowEvent<bool>? val) {
      if (!val!.value) return;

      // Put on top of stack.
      _windows.remove(window);
      _windows.add(window);

      int index = _windows.length - 2;
      if (index >= 0 && index < _windows.length) _windows[index].setFocus(false);

      _onUpdate();
    }

    // Init onPosChanged.
    void onPosChangedEvent(WindowEvent<Vector2>? val) {
      window.setFocus(true);
      _onUpdate();
    }

    // Subscribe to events
    window.onFocusChanged.subscribe(onFocusChangedEvent);
    window.onPosChanged.subscribe(onPosChangedEvent);

    // Add Window to List.
    _windows.add(window);
    window.setFocus(true);

    // Set initial position.
    Random rng = Random();
    window.setPos(Vector2(rng.nextDouble() * 500, rng.nextDouble() * 500));

    // Close callback
    /*TODO: Remove*/ print("createWindow set window close callback");
    window._close = () {
      // Unsubscribe from events
      window.onFocusChanged.unsubscribe(onFocusChangedEvent);
      window.onPosChanged.unsubscribe(onPosChangedEvent);

      // Remove window and rebuild widget tree.
      _windows.remove(window);
      _onUpdate();
    };

    // Update Widgets after adding the new window.
    _onUpdate();
    /*TODO: Remove*/ print("Window creation done. Returning window object. Window list: $windows");
    return window;
  }
}
