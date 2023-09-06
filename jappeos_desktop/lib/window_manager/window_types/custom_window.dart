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

/// Makes a custom window, does not support decorations.
class CustomWindow extends WMWindowType {
  final String? title;
  final Image? icon;
  final Widget body;

  final WMWindowSize size;
  final bool blur;
  final bool controlButtons;
  final bool hasTitlebar;
  final bool canResize;
  final bool useDecorationExtent;

  CustomWindow(
      {this.title,
      this.icon,
      this.useDecorationExtent = false,
      this.canResize = true,
      this.controlButtons = true,
      this.hasTitlebar = false,
      this.size = const WMWindowSize(Size(500, 500), Size(500, 500)),
      this.blur = false,
      required this.body});

  double get decorationExtent => 10;

  @override
  List<Widget> getWindow() {
    double tbarHeight = WMWindowDragAreaProperties.getDefaultH();

    return [
      Positioned(
        top: hasTitlebar ? tbarHeight : 5,
        left: 0,
        bottom: 0,
        right: 0,
        child: body,
      ),
      if (title != null)
        Positioned(
          top: 6,
          left: 10,
          child: DeuiText(isTitle: false, text: title ?? ""),
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

    if (useDecorationExtent) {
      a.h += decorationExtent;
    }

    return a;
  }

  @override
  WMWindowSize getSizeProperties() {
    return size;
  }

  @override
  bool hasControlButtons() {
    return controlButtons;
  }
}
