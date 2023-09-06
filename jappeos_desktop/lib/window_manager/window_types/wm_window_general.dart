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

/// Size properties for windows.
class WMWindowSize {
  final Size minimumSize;
  final Size defaultSize;

  const WMWindowSize(this.minimumSize, this.defaultSize);
}

/// Properties for the window dragging area (size & position).
/// TODO : Add a way to get drag area height for decorated windows so that they can be used across different window types (or find a better way).
class WMWindowDragAreaProperties {
  late double x, y, w, h;

  /// Set a custom dragging area for the window.
  void set(double x, y, w, h) {
    if (MOBILE_MODE) {
      setZero();
      return;
    }

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  /// Set the default dragging area for the window.
  void setDefault() {
    set(getDefaultX(), getDefaultY(), getDefaultW(), getDefaultH());
  }

  /// Set the full dragging area for the window. Fills up the whole window!
  void setFilled() {
    set(getDefaultX(), getDefaultY(), -1, -1.1);
  }

  /// Disable dragging area, used for mobile mode. Note that [set] is not used here
  /// since it would end up in a infinite loop anyways.
  void setZero() {
    x = 0;
    y = 0;
    w = 0;
    h = 0;
  }

  static double getDefaultX() {
    return 0;
  }

  static double getDefaultY() {
    return 0;
  }

  static double getDefaultW() {
    return !MOBILE_MODE ? -1 : 0;
  }

  static double getDefaultH() {
    return !MOBILE_MODE ? 35 : 0;
  }

  WMWindowDragAreaProperties();
}

/// A type of a window has to be extended from this class to be used.
abstract class WMWindowType {
  bool _windowSet = false;
  bool get windowSet => _windowSet;
  late Window _window;
  Window get theWindow => _window;
  void setThisWindow(Window window) {
    if (_windowSet) return;
    _window = window;
    _windowSet = true;
  }

  // Required paprameters to build window
  List<Widget> getWindow();
  bool applyBlur();
  bool isResizable();
  bool hasControlButtons();
  WMWindowSize getSizeProperties();

  // Optional parameters to build window
  WMWindowDragAreaProperties? getDragAreaProperties();
}

/// Get different window widgets and use them in your window.
class WMWindowWidgets {
  static Widget getTitlebar() {
    return const Placeholder(
      fallbackHeight: 35,
    );
  }
}
