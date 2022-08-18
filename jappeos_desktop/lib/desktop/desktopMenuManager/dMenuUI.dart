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

// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jappeos_desktop/desktop/desktopMenuManager/dMenuController.dart';
import 'package:jappeos_desktop/system/desktopCfg.dart';

class DesktopMenu$UI extends StatefulWidget {
  double w;
  double h;
  double x;
  double y;
  DesktopMenu$Menus menu;
  Widget? body;

  DesktopMenu$UI(this.menu, this.body, this.x, this.y, this.w, this.h) : super(key: UniqueKey()) {}

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<DesktopMenu$UI> {
  static MenuState I = new MenuState();

  // The border radius of the window
  var _borderRadius = 10.0;

  // BoxShadow list
  List<BoxShadow> _bsList = [
    BoxShadow(
      color: Color.fromARGB(70, 0, 0, 0),
      spreadRadius: 5,
      blurRadius: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        border: Border.all(
            color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BORDER_COLOR_DARK
                : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BORDER_COLOR_LIGHT,
            width: 1,
            style: BorderStyle.solid),
        boxShadow: _bsList,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        child: Stack(
          children: [
            Column(
              children: [_getBody()],
            ),
          ],
        ),
      ),
    );
  }

  // The body of the window.
  _getBody() {
    return Container(
      width: widget.w,
      height: widget.h,
      color: Colors.transparent,
      child: blurContainer(
        widget.body!,
      ),
    );
  }

  // Blur effects
  /// A blurry container widget that can be used to render background blur on the window.
  ///
  /// Parameters:
  /// ```dart
  /// - Widget child // The widget inside this widget.
  /// ```
  ///
  /// Made by Jappe. (2022)
  Widget blurContainer(Widget child) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
        child: Container(
          width: widget.w,
          height: widget.h,
          color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
              ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BLUR_COLOR_DARK
              : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BLUR_COLOR_LIGHT,
          child: child,
        ),
      ),
    );
  }
}
