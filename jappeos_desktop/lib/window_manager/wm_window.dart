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

part of window_manager;

/// This is the window [Widget] that every application can instantiate.
class Window extends StatefulWidget {
  @override
  _WindowState createState() => _WindowState();

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
    if (isMaximized) scheduleLate(WindowFunction.restore);
    //onWindowDragged!(0, 0); // Restore
  }

  Offset getPos() => Offset(_x, _y);
  double _x = 0, _y = 0;
  double prevX = 0, prevY = 0;
  double w = 0, h = 0;
  double prevW = 0, prevH = 0;
  //
  bool isMaximized = false;
  bool isActive = false;

  // Window Functions
  Function(double, double)? onWindowDragged;
  VoidCallback? onCloseButtonClicked;

  late bool cancelSendToTop = false;
  VoidCallback? onSendToTop;

  final List<WindowFunction> _scheduled = [];
  final List<WindowFunction> _scheduledIterable = [];
  void scheduleLate(WindowFunction func) {
    _scheduled.add(func);
  }

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
    _hasControlButtons = !MOBILE_MODE ? windowType.hasControlButtons() : false;
    _dragAreaProperties = windowType.getDragAreaProperties();
    _windowSizeProp = windowType.getSizeProperties();

    windowType.setThisWindow(this); // Set reference to this window in the window type.

    w = _windowSizeProp.defaultSize.width;
    h = _windowSizeProp.defaultSize.height;
  }
}

/// State for [Window], there should never be any need to access this class straight.
class _WindowState extends State<Window> {
  Timer? _scheduleLateTimer;

  @override
  void initState() {
    super.initState();

    // Manage scheduled functions.
    _scheduleLateTimer = Timer.periodic(const Duration(milliseconds: 200), (Timer timer) {
      if (widget._scheduled.isEmpty) return;

      widget._scheduledIterable
        ..clear()
        ..addAll(widget._scheduled);

      for (int i = 0; i < widget._scheduledIterable.length; i++) {
        var wf = widget._scheduledIterable[i];

        switch (wf) {
          case WindowFunction.maximize:
            {
              _statefuncOnMaximize();
              break;
            }
          case WindowFunction.restore:
            {
              _statefuncOnRestore();
              break;
            }
        }
        widget._scheduled.remove(wf);
      }
    });
  }

  @override
  void dispose() {
    _scheduleLateTimer?.cancel();
    _scheduleLateTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MOBILE_MODE) _statefuncOnMaximize();

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
          gradient: false,
          bordered: !widget.isMaximized,
          width: widget.w,
          height: widget.h,
          radiusSides: !widget.isMaximized ? BorderRadiusSides(true, true, true, true) : BorderRadiusSides(false, false, false, false),
          child: child,
        );
      } else {
        // Solid window background
        return DeuiSolidContainer(
          bordered: !widget.isMaximized,
          width: widget.w,
          height: widget.h,
          radiusSides: !widget.isMaximized ? BorderRadiusSides(true, true, true, true) : BorderRadiusSides(false, false, false, false),
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
                    _getWindowControlButton(context, !widget.isMaximized ? Icons.crop_square : Icons.fullscreen_exit, () {
                      if (widget.isMaximized) {
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
    if (widget._isResizable && !widget.isMaximized) {
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

  Offset? _dragOffset;
  bool _dragBool = false;
  bool _freeDrag = false;

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
        onPointerMove: (p) {
          _dragOffset = Offset(_dragOffset!.dx + p.delta.dx, _dragOffset!.dy + p.delta.dy);

          if ((_dragOffset!.dx.abs() < 10 && _dragOffset!.dy.abs() < 10) && !_freeDrag) {
            _dragBool = true;
            return;
          }

          _freeDrag = true;

          if (widget.isMaximized) {
            _statefuncOnRestore();
          } else {
            widget.onWindowDragged!(p.delta.dx + (_dragBool ? _dragOffset!.dx : 0), p.delta.dy + (_dragBool ? _dragOffset!.dy : 0));
            _dragBool = false;

            if (widget._y < 5) {
              widget._y = 5;
            }
          }
        },

        // When the titlebar is pressed
        onPointerDown: (p) {
          _dragOffset = Offset.zero;
          _freeDrag = false;
          if (!widget.isMaximized) widget.onWindowDragged!(0, 0);
        },

        onPointerUp: (p) {
          _dragOffset = null;
          _freeDrag = false;
        },
      ),
    );
  }

  /// The control button widget for the window frame
  Widget _getWindowControlButton(BuildContext context, IconData icon, Function()? onPress) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              mouseCursor: SystemMouseCursors.alias,
              borderRadius: BorderRadius.circular(30),
              onTap: onPress,
              child: Icon(
                icon,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // FUNCTIONS
  void _resizefuncOnHorizontalDragLeft(DragUpdateDetails details) {
    bool maximized = widget.isMaximized;
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
    bool maximized = widget.isMaximized;
    setState(() {
      if (maximized) _statefuncOnRestore();
      widget.w += details.delta.dx;
      if (widget.w < widget._windowSizeProp.minimumSize.width) {
        widget.w = widget._windowSizeProp.minimumSize.width;
      }
      widget.onWindowDragged!(0, 0);
    });
  }

  void _resizefuncOnHorizontalDragBottom(DragUpdateDetails details) {
    bool maximized = widget.isMaximized;
    setState(() {
      if (maximized) _statefuncOnRestore();
      widget.h += details.delta.dy;
      if (widget.h < widget._windowSizeProp.minimumSize.height) {
        widget.h = widget._windowSizeProp.minimumSize.height;
      }
      widget.onWindowDragged!(0, 0);
    });
  }

  void _resizefuncOnHorizontalDragTop(DragUpdateDetails details) {
    bool maximized = widget.isMaximized;
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
      widget.isMaximized = true;
    });
  }

  /// Called to restore the window from maximized mode.
  void _statefuncOnRestore() {
    if (!widget._isResizable || MOBILE_MODE) return;
    setState(() {
      widget.w = widget.prevW;
      widget.h = widget.prevH;
      widget._x = widget.prevX;
      widget._y = widget.prevY;
      widget.onWindowDragged!(0, 0);
      widget.isMaximized = false;
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

/// A window function that can be externally scheduled to be called on the [Window].
enum WindowFunction {
  /// Maximizes the window.
  maximize,

  /// Restores the window from maximized mode.
  restore
}
