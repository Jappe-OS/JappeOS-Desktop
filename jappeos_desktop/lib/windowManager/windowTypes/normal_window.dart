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
import 'package:jappeos_desktop_ui/widgets/text.dart';

/// This is the default type for every window.
class NormalWindow extends WMWindowType {
  final String title;
  final Image? icon;
  final Widget body;

  final WMWindowSize size;
  final bool blur;

  NormalWindow(this.title, this.icon, this.size, this.blur, this.body);

  @override
  List<Widget> getWindow() {
    return [
      Positioned(
        top: WMWindowDragAreaProperties.getDefaultH(),
        left: 0,
        bottom: 0,
        right: 0,
        child: body,
      ),
      Positioned(
        top: 6,
        left: 5,
        child: DeuiText(isTitle: false, text: title),
      ),
    ];
  }

  @override
  bool applyBlur() {
    return blur;
  }

  @override
  bool isResizable() {
    return true;
  }

  @override
  WMWindowDragAreaProperties? getDragAreaProperties() {
    WMWindowDragAreaProperties a = WMWindowDragAreaProperties()..setDefault();

    return a;
  }

  @override
  WMWindowSize getSizeProperties() {
    return size;
  }
}
