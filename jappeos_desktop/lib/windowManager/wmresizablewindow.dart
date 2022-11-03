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
import 'package:jappeos_desktop/system/desktop_cfg.dart';
import 'package:jappeos_desktop/system/widgets/basic/blur_container.dart';
import 'package:provider/provider.dart';

class ResizableWindow extends StatefulWidget {
  late double currentHeight, defaultHeight = defaultSize == null ? 400.0 : defaultSize!.height;
  late double currentWidth, defaultWidth = defaultSize == null ? 400.0 : defaultSize!.width;
  late double? oldHeight;
  late double? oldWidth;
  bool? isMaximized;
  double? x;
  double? y;

  String? title;
  Widget? body;
  Widget? cwd;
  bool isBlurry;
  Size? defaultSize;
  Size minimumSize;

  Function(double, double)? onWindowDragged;
  VoidCallback? onCloseButtonClicked;

  ResizableWindow(this.title, this.body, this.cwd, this.isBlurry, this.defaultSize, this.minimumSize) : super(key: UniqueKey()) {
    init();
  }

  void init() {
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
  static ResizableWindowState I = ResizableWindowState();

  // The height of the header
  late final _headerSize = widget.cwd == null ? 40.0 : 40.0 + 10;

  // The border radius of the window
  final _borderRadius = 10.0;

  // The size of the icons
  final double _iconSize = 18.5;

  // The size of the font
  final double _fontSize = 16;

  @override
  Widget build(BuildContext context) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    bool maximized = widget.isMaximized ?? false;

    // BoxShadow list
    final List<BoxShadow> bsList = [
      const BoxShadow(
        color: Color.fromARGB(70, 0, 0, 0),
        spreadRadius: 2,
        blurRadius: 30,
        offset: Offset(0, 5),
      ),
    ];

    if (widget.currentWidth < widget.minimumSize.width) {
      widget.currentWidth = widget.minimumSize.width;
    } else if (widget.currentHeight < widget.minimumSize.height) {
      widget.currentWidth = widget.minimumSize.width;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(maximized ? 0.0 : _borderRadius)),
        border: Border.all(color: themeColorGetters.getBorderColor(context), width: 1, style: BorderStyle.solid),
        boxShadow: maximized ? null : bsList,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(maximized ? 0.0 : _borderRadius)),
        child: Stack(
          children: [
            Column(
              children: [_getHeader(context), _getBody()],
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
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    opaque: true,
                    child: SizedBox(
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
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    opaque: true,
                    child: SizedBox(
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
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    opaque: true,
                    child: SizedBox(
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
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    opaque: true,
                    child: SizedBox(
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
  _getHeader(BuildContext context) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    bool maximized = widget.isMaximized ?? false;

    return GestureDetector(
      onPanUpdate: (tapInfo) {
        if (maximized) {
          _onRestore();
        } else {
          widget.onWindowDragged!(tapInfo.delta.dx, tapInfo.delta.dy);

          if (widget.y! < 5) {
            widget.y = 5;
          }
        }
      },
      onTap: () {
        widget.onWindowDragged!(0, 0);
      },
      onLongPressCancel: () {
        if (widget.y! < 25) {
          _onMaximize();
        }
      },
      child: headerBlurContainer(
        context,
        SizedBox(
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
                    headerButton(context, Icons.minimize_rounded, () {}),
                    Container(
                      width: 5,
                    ),
                    headerButton(context, maximized ? Icons.close_fullscreen_rounded : Icons.crop_square_rounded, () {
                      if (maximized) {
                        _onRestore();
                      } else {
                        _onMaximize();
                      }
                    }),
                    Container(
                      width: 5,
                    ),
                    headerButton(context, Icons.close_rounded, () {
                      widget.onCloseButtonClicked!();
                    }),
                  ],
                ),
              ),
              Positioned.fill(
                  child: Center(
                child: Text(
                  widget.title!,
                  style: TextStyle(fontSize: _fontSize, color: themeColorGetters.getTextColor(context, DesktopCfg$TextColorType.title)),
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
          context,
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
      widget.isMaximized = false;
    });
  }

  void _onHorizontalDragLeft(DragUpdateDetails details) {
    bool maximized = widget.isMaximized ?? false;
    setState(() {
      if (maximized) _onRestore();
      widget.currentWidth -= details.delta.dx;
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
  Widget blurContainer(BuildContext context, Widget child) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    if (widget.isBlurry) {
      return ClipRRect(
        child: UIBlurContainer(
          child: SizedBox(
            width: widget.currentWidth,
            height: _headerSize,
            //color: themeColorGetters.getBackgroundColor(context, DesktopCfg$BackgroundColorType.normal),
            child: child,
          ),
        ),
      );
    } else {
      return ClipRRect(
        child: Container(
          width: widget.currentWidth,
          height: _headerSize,
          color: themeColorGetters.getBackgroundColor(context, DesktopCfg$BackgroundColorType.normal),
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
  Widget headerBlurContainer(BuildContext context, Widget child) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    if (widget.isBlurry) {
      return ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
          child: Container(
            width: widget.currentWidth,
            height: _headerSize,
            color: themeColorGetters.getBackgroundColor(context, DesktopCfg$BackgroundColorType.normal),
            child: child,
          ),
        ),
      );
    } else {
      return ClipRRect(
        child: Container(
          width: widget.currentWidth,
          height: _headerSize,
          color: themeColorGetters.getBackgroundColor(context, DesktopCfg$BackgroundColorType.normal),
          child: child,
        ),
      );
    }
  }

  // Button
  /// A button that can be used in the titlebar/header.
  Widget headerButton(BuildContext context, IconData icon, void Function()? onPress) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    return SizedBox(
      width: 30,
      height: 30,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          enabledMouseCursor: SystemMouseCursors.alias,
          disabledMouseCursor: SystemMouseCursors.alias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPress,
        child: Icon(
          icon,
          size: _iconSize,
          color: themeColorGetters.getTextColor(context, DesktopCfg$TextColorType.title),
        ),
      ),
    );
  }
}
