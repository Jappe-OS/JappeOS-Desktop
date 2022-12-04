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
import 'package:jappeos_desktop/windowManager/windowTypes/wm_window_general.dart';

/// This is the default type for every window.
class NormalWindow extends WMWindowType {
  final String title;
  final Image icon;
  final Widget body;

  final WMWindowSize size;

  NormalWindow(this.title, this.icon, this.size, this.body);

  @override
  Widget getWindow() {
    return Positioned(
      top: WMWindowDragAreaProperties.getDefaultH(),
      left: 0,
      bottom: 0,
      right: 0,
      child: body
    );
  }

  @override
  bool applyBlur() {
    return false;
  }

  @override
  bool isResizable() {
    return true;
  }

  @override
  WMWindowDragAreaProperties? getDragAreaProperties() {
    return null;
  }

  @override
  WMWindowSize getSizeProperties() {
    return size;
  }
}
