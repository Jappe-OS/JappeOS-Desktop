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

// ignore_for_file: must_be_immutable, library_private_types_in_public_api, curly_braces_in_flow_control_structures

import 'package:event/event.dart';
import 'package:flutter/material.dart';
import 'package:jappeos_desktop/windowManager/windowTypes/wm_window_general.dart';
import 'package:jappeos_desktop_ui/widgets/blur_container.dart';
import 'package:jappeos_desktop_ui/widgets/solid_container.dart';
import 'package:shade_theming/shade_theming.dart';

/// This is the window [Widget] that every application can instantiate.
class Window extends StatefulWidget {
  @override
  _WindowState createState() => _WindowState();

  // Accessing _WindowState from Window: Global key to access the state
  static GlobalKey<_WindowState> myWidgetStateKey = GlobalKey<_WindowState>();
  _WindowState? state = myWidgetStateKey.currentState;

  // Window Properties & Info
  late List<Widget> _window;
  late bool _applyBlur;
  late bool _isResizable;
  late bool _hasControlButtons;
  late WMWindowSize _windowSizeProp;
  WMWindowDragAreaProperties? _dragAreaProperties;

  // Current Window States
  void setPos(double? x, y) {
    if (x != null) _x = x;
    if (y != null) _y = y;
  }

  Offset getPos() => Offset(_x, _y);
  double _x = 0, _y = 0;
  double prevX = 0, prevY = 0;
  double w = 0, h = 0;
  double prevW = 0, prevH = 0;
  //
  bool _isMaximized = false;

  // Window Functions
  Function(double, double)? onWindowDragged;
  VoidCallback? onCloseButtonClicked;
  //
  late bool cancelSendToTop = false;
  VoidCallback? onSendToTop;
  //
  void setMaximized(bool b) => state!.p_setMaximized(b);

  // Window Events
  var onWindowDraggedEvent = Event<WindowDragEventArgs>();
  var onWindowClosedEvent = Event();

  // Type of the Window
  final WMWindowType windowType;

  // Construct the Window
  Window(this.windowType) : super(key: UniqueKey()) {
    _window = windowType.getWindow();
    _applyBlur = windowType.applyBlur();
    _isResizable = windowType.isResizable();
    _hasControlButtons = windowType.hasControlButtons();
    _dragAreaProperties = windowType.getDragAreaProperties();
    _windowSizeProp = windowType.getSizeProperties();

    windowType.setThisWindow(this); // Set reference to this window in the window type.

    w = _windowSizeProp.defaultSize.width;
    h = _windowSizeProp.defaultSize.height;
  }
}

/// State for [Window], there should never be any need to access this class straight.
class _WindowState extends State<Window> {
  // ignore: non_constant_identifier_names
  void p_setMaximized(bool b) {
    if (b)
      _statefuncOnMaximize();
    else
      _statefuncOnRestore();
  }

  @override
  Widget build(BuildContext context) {
    // Width and height
    if (widget.w < widget._windowSizeProp.minimumSize.width) {
      widget.w = widget._windowSizeProp.minimumSize.width;
    } else if (widget.h < widget._windowSizeProp.minimumSize.height) {
      widget.h = widget._windowSizeProp.minimumSize.height;
    }

    // Children of the base window widget
    List<Widget> baseChildren = [];

    // The window base widget, anything can be added on top later on
    Widget base(Widget child) {
      if (widget._applyBlur) {
        // Blurred window background
        return DeuiBlurContainer(
          reducedRadius: true,
          gradient: true,
          bordered: !widget._isMaximized,
          width: widget.w,
          height: widget.h,
          radiusSides: !widget._isMaximized ? BorderRadiusSides(true, true, true, true) : BorderRadiusSides(false, false, false, false),
          child: child,
        );
      } else {
        // Solid window background
        return DeuiSolidContainer(
          reducedRadius: true,
          bordered: !widget._isMaximized,
          width: widget.w,
          height: widget.h,
          radiusSides: !widget._isMaximized ? BorderRadiusSides(true, true, true, true) : BorderRadiusSides(false, false, false, false),
          child: child,
        );
      }
    }

    // Add all window content
    baseChildren.addAll(widget._window);

    // Drag area
    if (widget._dragAreaProperties != null) {
      baseChildren.add(_getDragArea());
    }

    // Window controls
    baseChildren.add(
      Positioned(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: widget._hasControlButtons
              ? [
                  _getWindowControlButton(context, Icons.minimize, () {}),
                  if (widget._isResizable)
                    _getWindowControlButton(context, !widget._isMaximized ? Icons.crop_square : Icons.fullscreen_exit, () {
                      if (widget._isMaximized) {
                        _statefuncOnRestore();
                      } else {
                        _statefuncOnMaximize();
                      }
                    }),
                  _getWindowControlButton(context, Icons.close, () {
                    widget.onCloseButtonClicked!();
                  }),
                  const SizedBox(
                    width: 5,
                  ),
                ]
              : [],
        ),
      ),
    );

    // Resize areas
    if (widget._isResizable && !widget._isMaximized) {
      baseChildren.addAll([
        // Right
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: GestureDetector(
            onHorizontalDragUpdate: _resizefuncOnHorizontalDragRight,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeLeftRight,
              opaque: true,
              child: Container(
                width: 4,
              ),
            ),
          ),
        ),
        // Left
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: GestureDetector(
            onHorizontalDragUpdate: _resizefuncOnHorizontalDragLeft,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeLeftRight,
              opaque: true,
              child: Container(
                width: 4,
              ),
            ),
          ),
        ),
        // Top
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: GestureDetector(
            onVerticalDragUpdate: _resizefuncOnHorizontalDragTop,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeUpDown,
              opaque: true,
              child: Container(
                height: 4,
              ),
            ),
          ),
        ),
        // Bottom
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onVerticalDragUpdate: _resizefuncOnHorizontalDragBottom,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeUpDown,
              opaque: true,
              child: Container(
                height: 4,
              ),
            ),
          ),
        ),
        // BottomRight
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onPanUpdate: _resizefuncOnHorizontalDragBottomRight,
            child: const MouseRegion(
              cursor: SystemMouseCursors.resizeUpLeftDownRight,
              opaque: true,
              child: SizedBox(
                height: 6,
                width: 6,
              ),
            ),
          ),
        ),
        // BottomLeft
        Positioned(
          bottom: 0,
          left: 0,
          child: GestureDetector(
            onPanUpdate: _resizefuncOnHorizontalDragBottomLeft,
            child: const MouseRegion(
              cursor: SystemMouseCursors.resizeUpRightDownLeft,
              opaque: true,
              child: SizedBox(
                height: 6,
                width: 6,
              ),
            ),
          ),
        ),
        // TopRight
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onPanUpdate: _resizefuncOnHorizontalDragTopRight,
            child: const MouseRegion(
              cursor: SystemMouseCursors.resizeUpRightDownLeft,
              opaque: true,
              child: SizedBox(
                height: 6,
                width: 6,
              ),
            ),
          ),
        ),
        // TopLeft
        Positioned(
          left: 0,
          top: 0,
          child: GestureDetector(
            onPanUpdate: _resizefuncOnHorizontalDragTopLeft,
            child: const MouseRegion(
              cursor: SystemMouseCursors.resizeUpLeftDownRight,
              opaque: true,
              child: SizedBox(
                height: 6,
                width: 6,
              ),
            ),
          ),
        ),
      ]);
    }

    // Last, return the window widget
    return SizedBox(
      child: base(
        Stack(
          children: baseChildren,
        ),
      ),
    );
  }

  /// Get the dragging area of the window, uses the specified settings
  Widget _getDragArea() {
    // Do the height calculations based on the drag area height setting
    double finalHeight;
    if (widget._dragAreaProperties!.h == -1) {
      finalHeight = WMWindowDragAreaProperties.getDefaultH();
    } else if (widget._dragAreaProperties!.h == -1.1) {
      finalHeight = widget.h - widget._dragAreaProperties!.y;
    } else {
      finalHeight = widget._dragAreaProperties!.h;
    }
    // Return the drag area widget
    return Positioned(
      left: widget._dragAreaProperties!.x,
      top: widget._dragAreaProperties!.y,
      width: widget._dragAreaProperties!.w == -1 ? widget.w - widget._dragAreaProperties!.x : widget._dragAreaProperties!.w,
      height: finalHeight,

      // Use listener to be able to click buttons through the dragging area!
      child: Listener(
        behavior: HitTestBehavior.translucent, // <<-

        // When the window is dragged
        onPointerMove: (tapInfo) {
          if (widget._isMaximized) {
            _statefuncOnRestore();
          } else {
            widget.onWindowDragged!(tapInfo.delta.dx, tapInfo.delta.dy);

            if (widget._y < 5) {
              widget._y = 5;
            }
          }
        },

        // When the titlebar is pressed
        onPointerDown: (p) {
          widget.onWindowDragged!(0, 0);
        },
      ),
    );
  }

  /// The control button widget for the window frame
  Widget _getWindowControlButton(BuildContext context, IconData icon, Function()? onPress) {
    return Container(
      width: 33,
      height: 33,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onPress,
            child: Icon(
              icon,
              color: SHUI_THEME_PROPERTIES(context).normalTextColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  // FUNCTIONS
  void _resizefuncOnHorizontalDragLeft(DragUpdateDetails details) {
    bool maximized = widget._isMaximized;
    setState(() {
      if (maximized) _statefuncOnRestore();
      widget.w -= details.delta.dx;
      if (widget.w < widget._windowSizeProp.minimumSize.width) {
        widget.w = widget._windowSizeProp.minimumSize.width;
      } else {
        widget.onWindowDragged!(details.delta.dx, 0);
      }
    });
  }

  void _resizefuncOnHorizontalDragRight(DragUpdateDetails details) {
    bool maximized = widget._isMaximized;
    setState(() {
      if (maximized) _statefuncOnRestore();
      widget.w += details.delta.dx;
      if (widget.w < widget._windowSizeProp.minimumSize.width) {
        widget.w = widget._windowSizeProp.minimumSize.width;
      }
    });
  }

  void _resizefuncOnHorizontalDragBottom(DragUpdateDetails details) {
    bool maximized = widget._isMaximized;
    setState(() {
      if (maximized) _statefuncOnRestore();
      widget.h += details.delta.dy;
      if (widget.h < widget._windowSizeProp.minimumSize.height) {
        widget.h = widget._windowSizeProp.minimumSize.height;
      }
    });
  }

  void _resizefuncOnHorizontalDragTop(DragUpdateDetails details) {
    bool maximized = widget._isMaximized;
    setState(() {
      if (maximized) _statefuncOnRestore();
      widget.h -= details.delta.dy;
      if (widget.h < widget._windowSizeProp.minimumSize.height) {
        widget.h = widget._windowSizeProp.minimumSize.height;
      } else {
        widget.onWindowDragged!(0, details.delta.dy);
      }
    });
  }

  void _resizefuncOnHorizontalDragBottomRight(DragUpdateDetails details) {
    _resizefuncOnHorizontalDragRight(details);
    _resizefuncOnHorizontalDragBottom(details);
  }

  void _resizefuncOnHorizontalDragBottomLeft(DragUpdateDetails details) {
    _resizefuncOnHorizontalDragLeft(details);
    _resizefuncOnHorizontalDragBottom(details);
  }

  void _resizefuncOnHorizontalDragTopRight(DragUpdateDetails details) {
    _resizefuncOnHorizontalDragRight(details);
    _resizefuncOnHorizontalDragTop(details);
  }

  void _resizefuncOnHorizontalDragTopLeft(DragUpdateDetails details) {
    _resizefuncOnHorizontalDragLeft(details);
    _resizefuncOnHorizontalDragTop(details);
  }

  /// Called to maximize the window.
  void _statefuncOnMaximize() {
    if (!widget._isResizable) return;
    setState(() {
      widget.prevW = widget.w;
      widget.prevH = widget.h;
      widget.prevX = widget._x;
      widget.prevY = widget._y;
      widget.w = View.of(context).physicalSize.width + 2;
      widget.h = View.of(context).physicalSize.height - 30 + 2;
      widget._x = -1;
      widget._y = -1;
      widget.onWindowDragged!(0, 30);
      widget._isMaximized = true;
    });
  }

  /// Called to restore the window from maximized mode.
  void _statefuncOnRestore() {
    if (!widget._isResizable) return;
    setState(() {
      widget.w = widget.prevW;
      widget.h = widget.prevH;
      widget._x = widget.prevX;
      widget._y = widget.prevY;
      widget.onWindowDragged!(0, 0);
      widget._isMaximized = false;
    });
  }
}

/// Event arguments for window dragging, contains:
///
/// - Delta X
/// - Delta Y
class WindowDragEventArgs extends EventArgs {
  WindowDragEventArgs(this.dx, this.dy);

  /// Delta X
  final double dx;

  /// Delta Y
  final double dy;
}
