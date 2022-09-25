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
import 'package:jappeos_desktop/system/desktopCfg.dart';

class ResizableWindow extends StatefulWidget {
  late double currentHeight, defaultHeight = 400.0;
  late double currentWidth, defaultWidth = 400.0;
  late double? oldHeight;
  late double? oldWidth;
  double? x;
  double? y;
  String? title;
  Widget? body;
  Widget? cwd;
  bool? isMaximized;
  bool isBlurry;

  Function(double, double)? onWindowDragged;
  VoidCallback? onCloseButtonClicked;

  ResizableWindow(this.title, this.body, this.cwd, this.isBlurry) : super(key: UniqueKey()) {
    currentHeight = defaultHeight;
    currentWidth = defaultWidth;
    oldHeight = defaultHeight;
    oldWidth = defaultWidth;
    isMaximized = false;
  }

  @override
  ResizableWindowState createState() => ResizableWindowState();
}

class ResizableWindowState extends State<ResizableWindow> {
  static ResizableWindowState I = new ResizableWindowState();

  // The height of the header
  late var _headerSize = widget.cwd == null ? 40.0 : 40.0 + 10;

  // The border radius of the window
  var _borderRadius = 10.0;

  // The size of the icons
  double _iconSize = 18.5;

  // The size of the font
  double _fontSize = 16;

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
    bool maximized = widget.isMaximized ?? false;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(maximized ? 0.0 : _borderRadius)),
        border: Border.all(
            color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BORDER_COLOR_DARK
                : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BORDER_COLOR_LIGHT,
            width: 1,
            style: BorderStyle.solid),
        boxShadow: _bsList,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(maximized ? 0.0 : _borderRadius)),
        child: Stack(
          children: [
            Column(
              children: [_getHeader(), _getBody()],
            ),
            Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragRight,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    opaque: true,
                    child: Container(
                      width: 4,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragLeft,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    opaque: true,
                    child: Container(
                      width: 4,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragUpdate: _onHorizontalDragTop,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    opaque: true,
                    child: Container(
                      height: 4,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragUpdate: _onHorizontalDragBottom,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    opaque: true,
                    child: Container(
                      height: 4,
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onPanUpdate: _onHorizontalDragBottomRight,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    opaque: true,
                    child: Container(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                left: 0,
                child: GestureDetector(
                  onPanUpdate: _onHorizontalDragBottomLeft,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    opaque: true,
                    child: Container(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
            Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onPanUpdate: _onHorizontalDragTopRight,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    opaque: true,
                    child: Container(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                child: GestureDetector(
                  onPanUpdate: _onHorizontalDragTopLeft,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    opaque: true,
                    child: Container(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // The header/dragging area of the window.
  _getHeader() {
    bool maximized = widget.isMaximized ?? false;

    return GestureDetector(
      onPanUpdate: (tapInfo) {
        if (maximized) {
          _onRestore();
        } else {
          widget.onWindowDragged!(tapInfo.delta.dx, tapInfo.delta.dy);
        }
      },
      onTap: () {
        widget.onWindowDragged!(0, 0);
      },
      child: headerBlurContainer(
        Container(
          width: widget.currentWidth,
          height: _headerSize,
          child: Stack(
            children: [
              Positioned(
                top: 3,
                right: 7,
                bottom: 4,
                child: Row(
                  children: [
                    headerButton(Icons.minimize_rounded, () {}),
                    Container(
                      width: 5,
                    ),
                    headerButton(maximized ? Icons.close_fullscreen_rounded : Icons.crop_square_rounded, () {
                      if (maximized) {
                        _onRestore();
                      } else {
                        _onMaximize();
                      }
                    }),
                    Container(
                      width: 5,
                    ),
                    headerButton(Icons.close_rounded, () {
                      widget.onCloseButtonClicked!();
                    }),
                  ],
                ),
              ),
              Positioned.fill(
                  child: Center(
                child: Text(
                  widget.title!,
                  style: TextStyle(
                      fontSize: _fontSize,
                      color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                          ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_DARK
                          : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_LIGHT),
                ),
              )),
              Positioned(left: 7, right: 120, top: 7.5, height: _headerSize - 15, child: widget.cwd ?? Container()),
            ],
          ),
        ),
      ),
    );
  }

  // The body of the window.
  _getBody() {
    return GestureDetector(
      onTap: () {
        widget.onWindowDragged!(0, 0);
      },
      child: Container(
        width: widget.currentWidth,
        height: widget.currentHeight - _headerSize,
        color: Colors.transparent,
        child: blurContainer(
          widget.body!,
        ),
      ),
    );
  }

  void _onMaximize() {
    setState(() {
      widget.oldWidth = widget.currentWidth;
      widget.oldHeight = widget.currentHeight;
      widget.currentWidth = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
      widget.currentHeight = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height - 30;
      widget.x = -1;
      widget.y = -1;
      widget.onWindowDragged!(0, 30);
      _bsList.clear();
      widget.isMaximized = true;
    });
  }

  void _onRestore() {
    setState(() {
      widget.currentWidth = widget.oldWidth ?? widget.defaultWidth;
      widget.currentHeight = widget.oldHeight ?? widget.defaultHeight;
      widget.x = 100;
      widget.y = 100;
      widget.onWindowDragged!(0, 0);
      _bsList.add(new BoxShadow(
          color: Color.fromARGB(70, 0, 0, 0),
          spreadRadius: 5,
          blurRadius: 10,
      ),);
      widget.isMaximized = false;
    });
  }

  void _onHorizontalDragLeft(DragUpdateDetails details) {
    bool maximized = widget.isMaximized ?? false;
    setState(() {
      if (maximized) _onRestore();
      if (widget.currentWidth != null) widget.currentWidth -= details.delta.dx;
      if (widget.currentWidth < widget.defaultWidth) {
        widget.currentWidth = widget.defaultWidth;
      } else {
        widget.onWindowDragged!(details.delta.dx, 0);
      }
    });
  }

  void _onHorizontalDragRight(DragUpdateDetails details) {
    bool maximized = widget.isMaximized ?? false;
    setState(() {
      if (maximized) _onRestore();
      widget.currentWidth += details.delta.dx;
      if (widget.currentWidth < widget.defaultWidth) {
        widget.currentWidth = widget.defaultWidth;
      }
    });
  }

  void _onHorizontalDragBottom(DragUpdateDetails details) {
    bool maximized = widget.isMaximized ?? false;
    setState(() {
      if (maximized) _onRestore();
      widget.currentHeight += details.delta.dy;
      if (widget.currentHeight < widget.defaultHeight) {
        widget.currentHeight = widget.defaultHeight;
      }
    });
  }

  void _onHorizontalDragTop(DragUpdateDetails details) {
    bool maximized = widget.isMaximized ?? false;
    setState(() {
      if (maximized) _onRestore();
      widget.currentHeight -= details.delta.dy;
      if (widget.currentHeight < widget.defaultHeight) {
        widget.currentHeight = widget.defaultHeight;
      } else {
        widget.onWindowDragged!(0, details.delta.dy);
      }
    });
  }

  void _onHorizontalDragBottomRight(DragUpdateDetails details) {
    _onHorizontalDragRight(details);
    _onHorizontalDragBottom(details);
  }

  void _onHorizontalDragBottomLeft(DragUpdateDetails details) {
    _onHorizontalDragLeft(details);
    _onHorizontalDragBottom(details);
  }

  void _onHorizontalDragTopRight(DragUpdateDetails details) {
    _onHorizontalDragRight(details);
    _onHorizontalDragTop(details);
  }

  void _onHorizontalDragTopLeft(DragUpdateDetails details) {
    _onHorizontalDragLeft(details);
    _onHorizontalDragTop(details);
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
    if (widget.isBlurry) {
      return ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
          child: Container(
            width: widget.currentWidth,
            height: _headerSize,
            color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BLUR_COLOR_DARK
                : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BLUR_COLOR_LIGHT,
            child: child,
          ),
        ),
      );
    } else {
      return ClipRRect(
        child: Container(
          width: widget.currentWidth,
          height: _headerSize,
          color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
              ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_DARK
              : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_LIGHT,
          child: child,
        ),
      );
    }
  }

  /// A blurry container widget that can be used to render background blur on the window.
  ///
  /// Parameters:
  /// ```dart
  /// - Widget child // The widget inside this widget.
  /// ```
  ///
  /// Made by Jappe. (2022)
  Widget headerBlurContainer(Widget child) {
    if (widget.isBlurry) {
      return ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
          child: Container(
            width: widget.currentWidth,
            height: _headerSize,
            color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BLUR_COLOR_DARK
                : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BLUR_COLOR_LIGHT,
            child: child,
          ),
        ),
      );
    } else {
      return ClipRRect(
        child: Container(
          width: widget.currentWidth,
          height: _headerSize,
          color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
              ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_DARK_SECONDARY
              : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_LIGHT_SECONDARY,
          child: child,
        ),
      );
    }
  }

  // Button
  /// A button that can be used in the titlebar/header.
  ///
  /// Made by Jappe. (2022)
  Widget headerButton(IconData icon, void Function()? onPress) {
    return Container(
      width: 30,
      height: 30,
      child: TextButton(
        child: Icon(icon,
            size: _iconSize,
            color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_ICON_COLOR_DARK
                : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_ICON_COLOR_LIGHT),
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            enabledMouseCursor: SystemMouseCursors.alias,
            disabledMouseCursor: SystemMouseCursors.alias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        onPressed: onPress,
      ),
    );
  }
}
