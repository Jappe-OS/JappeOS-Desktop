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
  final WindowState windowState;

  final Function(Vector2 delta) resizeCallback;
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
      required this.windowState,
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

  @override
  Widget build(BuildContext context) {
    WindowHeader header = WindowHeader(
        maximizeButton: widget.windowIsResizable, windowPos: widget.windowPos, windowState: widget.windowState, posCallback: widget.posCallback, stateCallback: widget.stateCallback, closeCallback: widget.closeCallback);

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

    List<Widget> resizeAreas = !widget.windowIsResizable ? [] : [
      // Right
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
        child: GestureDetector(
          onHorizontalDragUpdate: _onHorizontalDragLeft,
          child: MouseRegion(
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
        child: GestureDetector(
          onVerticalDragUpdate: _onVerticalDragTop,
          child: MouseRegion(
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
        child: GestureDetector(
          onVerticalDragUpdate: _onVerticalDragBottom,
          child: MouseRegion(
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
        child: GestureDetector(
          onPanUpdate: (p0) {
            _onHorizontalDragRight(p0);
            _onVerticalDragBottom(p0);
          },
          child: const MouseRegion(
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
        child: GestureDetector(
          onPanUpdate: (p0) {
            _onHorizontalDragLeft(p0);
            _onVerticalDragBottom(p0);
          },
          child: const MouseRegion(
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
        child: GestureDetector(
          onPanUpdate: (p0) {
            _onHorizontalDragRight(p0);
            _onVerticalDragTop(p0);
          },
          child: const MouseRegion(
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
        child: GestureDetector(
          onPanUpdate: (p0) {
            _onHorizontalDragLeft(p0);
            _onVerticalDragTop(p0);
          },
          child: const MouseRegion(
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
          top: kResizeAreaThickness,
          left: kResizeAreaThickness,
          bottom: kResizeAreaThickness,
          right: kResizeAreaThickness,
          child: base(
            Column(
              children: [
                header,
                widget.content,
              ],
            ),
          ),
        ),
        ...resizeAreas
      ],
    );
  }

  void _onHorizontalDragLeft(DragUpdateDetails p0) {
    widget.posCallback(Vector2(widget.windowPos.x + p0.delta.dx, 0));
    widget.resizeCallback(Vector2(-p0.delta.dx, 0));
  }

  void _onHorizontalDragRight(DragUpdateDetails p0) {
    widget.resizeCallback(Vector2(p0.delta.dx, 0));
  }

  void _onVerticalDragTop(DragUpdateDetails p0) {
    widget.posCallback(Vector2(0, widget.windowPos.y + p0.delta.dy));
    widget.resizeCallback(Vector2(0, -p0.delta.dy));
  }

  void _onVerticalDragBottom(DragUpdateDetails p0) {
    widget.resizeCallback(Vector2(0, p0.delta.dy));
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
      required this.posCallback,
      required this.stateCallback,
      required this.closeCallback})
      : super(key: key);

  @override
  _WindowHeaderState createState() => _WindowHeaderState();
}

class _WindowHeaderState extends State<WindowHeader> {
  Offset? _dragOffset;
  bool _dragBool = false;
  bool _freeDrag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.customWindowDecorations != null ? 45 : 35,
      color: widget.customColor ?? Theme.of(context).colorScheme.background,
      child: Listener(
        // When the window is dragged
        onPointerMove: (p) {
          _dragOffset = Offset(_dragOffset!.dx + p.delta.dx, _dragOffset!.dy + p.delta.dy);

          if ((_dragOffset!.dx.abs() < 10 && _dragOffset!.dy.abs() < 10) && !_freeDrag) {
            _dragBool = true;
            return;
          }

          _freeDrag = true;

          widget.posCallback(Vector2(p.delta.dx + (_dragBool ? _dragOffset!.dx : 0), p.delta.dy + (_dragBool ? _dragOffset!.dy : 0)));
          _dragBool = false;

          if (widget.windowPos.y < 5) {
            widget.posCallback(Vector2(0, 5));
          }
        },

        // When the titlebar is pressed
        onPointerDown: (p) {
          _dragOffset = Offset.zero;
          _freeDrag = false;
          if (widget.windowState != WindowState.maximized) widget.posCallback(widget.windowPos);
        },

        onPointerUp: (p) {
          _dragOffset = null;
          _freeDrag = false;
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
    // TODO
    return widget.texture != null ? Image.memory(widget.texture!) : const Placeholder();
  }
}
