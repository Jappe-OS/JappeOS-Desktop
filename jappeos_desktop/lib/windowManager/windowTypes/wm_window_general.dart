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

/// Size properties for windows.
class WMWindowSize {
  final Size minimumSize;
  final Size defaultSize;

  WMWindowSize(this.minimumSize, this.defaultSize);
}

/// Properties for the window dragging area (size & position).
class WMWindowDragAreaProperties {
  late double x, y, w, h;

  /// Set a custom dragging area for the window.
  void set(double x, y, w, h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  /// Set the default dragging are for the window.
  void setDefault() {
    x = getDefaultX();
    y = getDefaultY();
    w = getDefaultW();
    h = getDefaultH();
  }

  static double getDefaultX() {
    return 0;
  }

  static double getDefaultY() {
    return 0;
  }

  static double getDefaultW() {
    return -1;
  }

  static double getDefaultH() {
    return 35;
  }

  WMWindowDragAreaProperties();
}

/// A type of a window has to be extended from this class to be used.
abstract class WMWindowType {
  // Required paprameters to build window
  Widget getWindow();
  bool applyBlur();
  bool isResizable();
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

//class DecoratedWindow extends WMWindowType {
//  final String title;
//  final Image icon;
//  final WMWindowSize size;
//  final Widget windowDecorations;
//  final Widget body;
//
//  DecoratedWindow(this.title, this.icon, this.size, this.windowDecorations, this.body);
//}
