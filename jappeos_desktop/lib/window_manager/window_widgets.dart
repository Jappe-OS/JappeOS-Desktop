//  JappeOS-Desktop, The desktop environment for JappeOS.
//  Copyright (C) 2023  Jappe02
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

// ignore_for_file: library_private_types_in_public_api

part of window_manager;

class WindowWidget extends StatefulWidget {
  final WindowContent content;

  final BackgroundMode windowBackgroundMode;
  final bool windowIsFocused;
  final bool windowIsResizable;
  final Vector2 windowPos;
  final Vector2 windowSize;
  final WindowState windowState;

  final Function(bool newVal) focusCallback;
  final Function(Vector2 newVal) resizeCallback;
  final Function(Vector2 newVal) posCallback;
  final Function(WindowState newVal) stateCallback;
  final Function() closeCallback;

  const WindowWidget(
      {Key? key,
      required this.content,
      required this.windowBackgroundMode,
      required this.windowIsFocused,
      required this.windowIsResizable,
      required this.windowPos,
      required this.windowSize,
      required this.windowState,
      required this.focusCallback,
      required this.resizeCallback,
      required this.posCallback,
      required this.stateCallback,
      required this.closeCallback})
      : super(key: key);

  @override
  _WindowWidgetState createState() => _WindowWidgetState();
}

class _WindowWidgetState extends State<WindowWidget> {
  static const kResizeAreaThickness = 5.0;

  Vector2 oldWindowPos = Vector2.zero();
  Vector2 oldWindowSize = Vector2.zero();
  Offset? _dragOffset;

  @override
  Widget build(BuildContext context) {
    WindowHeader header = WindowHeader(
        maximizeButton: widget.windowIsResizable,
        windowPos: widget.windowPos,
        windowState: widget.windowState,
        focusCallback: widget.focusCallback,
        posCallback: widget.posCallback,
        stateCallback: widget.stateCallback,
        closeCallback: widget.closeCallback);

    // The window base widget, anything can be added on top later on
    Widget base(Widget child) {
      if (widget.windowBackgroundMode == BackgroundMode.blurredTransp) {
        // Blurred window background
        return DeuiBlurContainer(
          gradient: false,
          bordered: widget.windowState == WindowState.normal,
          radiusSides:
              widget.windowState != WindowState.maximized ? BorderRadiusSides(true, true, true, true) : BorderRadiusSides(false, false, false, false),
          child: child,
        );
      } else {
        // Solid window background
        return DeuiSolidContainer(
          bordered: widget.windowState == WindowState.normal,
          radiusSides:
              widget.windowState != WindowState.maximized ? BorderRadiusSides(true, true, true, true) : BorderRadiusSides(false, false, false, false),
          child: child,
        );
      }
    }

    List<Widget> resizeAreas = !widget.windowIsResizable || widget.windowState != WindowState.normal
        ? []
        : [
            // Right
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: _resizeArea(
                (p) {
                  _dragOffset = Offset(_dragOffset!.dx + p.delta.dx, _dragOffset!.dy + p.delta.dy);

                  widget.resizeCallback(Vector2(
                    oldWindowSize.x + _dragOffset!.dx,
                    widget.windowSize.y,
                  ));
                },
                MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  opaque: true,
                  child: Container(
                    width: kResizeAreaThickness,
                  ),
                ),
              ),
            ),
            // Left
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: _resizeArea(
                (p) {
                  _dragOffset = Offset(_dragOffset!.dx + p.delta.dx, _dragOffset!.dy + p.delta.dy);

                  widget.resizeCallback(Vector2(
                    oldWindowSize.x - _dragOffset!.dx,
                    widget.windowSize.y,
                  ));

                  widget.posCallback(Vector2(
                    oldWindowPos.x + _dragOffset!.dx,
                    widget.windowPos.y,
                  ));
                },
                MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  opaque: true,
                  child: Container(
                    width: kResizeAreaThickness,
                  ),
                ),
              ),
            ),
            // Top
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: _resizeArea(
                (p) {
                  _dragOffset = Offset(_dragOffset!.dx + p.delta.dx, _dragOffset!.dy + p.delta.dy);

                  widget.resizeCallback(Vector2(
                    widget.windowSize.x,
                    oldWindowSize.y - _dragOffset!.dy,
                  ));

                  widget.posCallback(Vector2(
                    widget.windowPos.x,
                    oldWindowPos.y + _dragOffset!.dy,
                  ));
                },
                MouseRegion(
                  cursor: SystemMouseCursors.resizeUpDown,
                  opaque: true,
                  child: Container(
                    height: kResizeAreaThickness,
                  ),
                ),
              ),
            ),
            // Bottom
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: _resizeArea(
                (p) {
                  _dragOffset = Offset(_dragOffset!.dx + p.delta.dx, _dragOffset!.dy + p.delta.dy);

                  widget.resizeCallback(Vector2(
                    widget.windowSize.x,
                    oldWindowSize.y + _dragOffset!.dy,
                  ));
                },
                MouseRegion(
                  cursor: SystemMouseCursors.resizeUpDown,
                  opaque: true,
                  child: Container(
                    height: kResizeAreaThickness,
                  ),
                ),
              ),
            ),
            // BottomRight
            Positioned(
              bottom: 0,
              right: 0,
              child: _resizeArea(
                (p) {
                  _dragOffset = Offset(_dragOffset!.dx + p.delta.dx, _dragOffset!.dy + p.delta.dy);

                  widget.resizeCallback(Vector2(
                    oldWindowSize.x + _dragOffset!.dx,
                    oldWindowSize.y + _dragOffset!.dy,
                  ));
                },
                const MouseRegion(
                  cursor: SystemMouseCursors.resizeUpLeftDownRight,
                  opaque: true,
                  child: SizedBox(
                    height: 1.5 * kResizeAreaThickness,
                    width: 1.5 * kResizeAreaThickness,
                  ),
                ),
              ),
            ),
            // BottomLeft
            Positioned(
              bottom: 0,
              left: 0,
              child: _resizeArea(
                (p) {
                  _dragOffset = Offset(_dragOffset!.dx + p.delta.dx, _dragOffset!.dy + p.delta.dy);

                  widget.resizeCallback(Vector2(
                    oldWindowSize.x - _dragOffset!.dx,
                    oldWindowSize.y + _dragOffset!.dy,
                  ));

                  widget.posCallback(Vector2(
                    oldWindowPos.x + _dragOffset!.dx,
                    widget.windowPos.y,
                  ));
                },
                const MouseRegion(
                  cursor: SystemMouseCursors.resizeUpRightDownLeft,
                  opaque: true,
                  child: SizedBox(
                    height: 1.5 * kResizeAreaThickness,
                    width: 1.5 * kResizeAreaThickness,
                  ),
                ),
              ),
            ),
            // TopRight
            Positioned(
              top: 0,
              right: 0,
              child: _resizeArea(
                (p) {
                  _dragOffset = Offset(_dragOffset!.dx + p.delta.dx, _dragOffset!.dy + p.delta.dy);

                  widget.resizeCallback(Vector2(
                    oldWindowSize.x + _dragOffset!.dx,
                    oldWindowSize.y - _dragOffset!.dy,
                  ));

                  widget.posCallback(Vector2(
                    widget.windowPos.x,
                    oldWindowPos.y + _dragOffset!.dy,
                  ));
                },
                const MouseRegion(
                  cursor: SystemMouseCursors.resizeUpRightDownLeft,
                  opaque: true,
                  child: SizedBox(
                    height: 1.5 * kResizeAreaThickness,
                    width: 1.5 * kResizeAreaThickness,
                  ),
                ),
              ),
            ),
            // TopLeft
            Positioned(
              left: 0,
              top: 0,
              child: _resizeArea(
                (p) {
                  _dragOffset = Offset(_dragOffset!.dx + p.delta.dx, _dragOffset!.dy + p.delta.dy);

                  widget.resizeCallback(Vector2(
                    oldWindowSize.x - _dragOffset!.dx,
                    oldWindowSize.y - _dragOffset!.dy,
                  ));

                  widget.posCallback(Vector2(
                    oldWindowPos.x + _dragOffset!.dx,
                    oldWindowPos.y + _dragOffset!.dy,
                  ));
                },
                const MouseRegion(
                  cursor: SystemMouseCursors.resizeUpLeftDownRight,
                  opaque: true,
                  child: SizedBox(
                    height: 1.5 * kResizeAreaThickness,
                    width: 1.5 * kResizeAreaThickness,
                  ),
                ),
              ),
            ),
          ];

    return Stack(
      children: [
        Positioned(
          top: widget.windowState == WindowState.normal ? kResizeAreaThickness : 0,
          left: widget.windowState == WindowState.normal ? kResizeAreaThickness : 0,
          bottom: widget.windowState == WindowState.normal ? kResizeAreaThickness : 0,
          right: widget.windowState == WindowState.normal ? kResizeAreaThickness : 0,
          child: base(
            Column(
              children: [
                header,
                Expanded(child: widget.content),
              ],
            ),
          ),
        ),
        ...resizeAreas
      ],
    );
  }

  Widget _resizeArea(void Function(PointerMoveEvent) onPointerMove, Widget child) {
    return Listener(
      onPointerMove: onPointerMove,
      onPointerDown: (p) {
        _dragOffset = Offset.zero;
        oldWindowSize = widget.windowSize;
        oldWindowPos = widget.windowPos;
      },
      onPointerUp: (p) {
        _dragOffset = null;
        oldWindowSize = Vector2.zero();
        oldWindowPos = Vector2.zero();
      },
      child: child,
    );
  }
}

class WindowHeader extends StatefulWidget {
  final ImageProvider? icon;
  final String? title;
  final bool maximizeButton;
  final Widget? customWindowDecorations;
  final Color? customColor;

  final Vector2 windowPos;
  final WindowState windowState;

  final Function(bool newVal) focusCallback;
  final Function(Vector2 newVal) posCallback;
  final Function(WindowState newVal) stateCallback;
  final Function() closeCallback;

  const WindowHeader(
      {Key? key,
      this.icon,
      this.title,
      this.maximizeButton = true,
      this.customWindowDecorations,
      this.customColor,
      required this.windowPos,
      required this.windowState,
      required this.focusCallback,
      required this.posCallback,
      required this.stateCallback,
      required this.closeCallback})
      : super(key: key);

  @override
  _WindowHeaderState createState() => _WindowHeaderState();
}

class _WindowHeaderState extends State<WindowHeader> {
  Vector2 oldWindowPos = Vector2.zero();
  Offset? _dragOffset;
  bool _freeDrag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.customWindowDecorations != null ? 45 : 35,
      color: widget.customColor ?? Theme.of(context).colorScheme.background,
      child: Listener(
        behavior: HitTestBehavior.translucent,

        // When the window is dragged
        onPointerMove: (p) {
          _dragOffset = Offset(_dragOffset!.dx + p.delta.dx, _dragOffset!.dy + p.delta.dy);

          if ((_dragOffset!.dx.abs() < 10 && _dragOffset!.dy.abs() < 10) && !_freeDrag) {
            return;
          }

          _freeDrag = true;

          widget.posCallback(Vector2(
            oldWindowPos.x + _dragOffset!.dx,
            oldWindowPos.y + _dragOffset!.dy,
          ));
        },

        // When the titlebar is pressed
        onPointerDown: (p) {
          _dragOffset = Offset.zero;
          oldWindowPos = widget.windowPos;
          _freeDrag = false;
          widget.focusCallback(true);
        },

        onPointerUp: (p) {
          _dragOffset = null;
          oldWindowPos = Vector2.zero();
          _freeDrag = false;

          if (widget.windowPos.y < -5) {
            widget.posCallback(Vector2(widget.windowPos.x, 0));
          }
        },

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.icon != null) Image(image: widget.icon!),
            if (widget.title != null) DeuiText(isTitle: false, text: widget.title!),
            if (widget.customWindowDecorations != null) ...[
              Expanded(child: widget.customWindowDecorations!),
            ] else
              const Spacer(),
            _getWindowControlButton(context, Icons.minimize, () => widget.stateCallback(WindowState.minimized)),
            if (widget.maximizeButton) ...[
              if (widget.windowState == WindowState.normal) ...[
                _getWindowControlButton(context, Icons.crop_square, () => widget.stateCallback(WindowState.maximized)),
              ] else
                _getWindowControlButton(context, Icons.fullscreen_exit, () => widget.stateCallback(WindowState.normal)),
            ],
            _getWindowControlButton(context, Icons.close, () => widget.closeCallback()),
          ],
        ),
      ),
    );
  }

  Widget _getWindowControlButton(BuildContext context, IconData icon, Function()? onPress) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: SizedBox(
        width: 30,
        height: 30,
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: Colors.transparent,
              mouseCursor: SystemMouseCursors.alias,
              borderRadius: BorderRadius.circular(30),
              onTap: onPress,
              child: Center(
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Theme.of(context).colorScheme.onInverseSurface),
                  child: Icon(
                    icon,
                    size: 13,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WindowContent extends StatefulWidget {
  final Uint8List? texture;

  const WindowContent({Key? key, this.texture}) : super(key: key);

  @override
  _WindowContentState createState() => _WindowContentState();
}

class _WindowContentState extends State<WindowContent> {
  @override
  Widget build(BuildContext context) {
    print(" --- Window Contents Rebuilt!!!"); // TODO: Remove print
    return widget.texture != null ? Image.memory(widget.texture!, fit: BoxFit.fill) : const Placeholder();
  }
}
