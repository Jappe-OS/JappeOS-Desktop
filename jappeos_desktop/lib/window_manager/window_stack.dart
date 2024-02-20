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

// ignore_for_file: library_private_types_in_public_api

part of window_manager;

/// A widget to manage windows.
class WindowStack extends StatefulWidget {
  final WindowStackController? wmController;
  final EdgeInsetsGeometry insets;

  const WindowStack({Key? key, this.wmController, this.insets = EdgeInsets.zero}) : super(key: key);

  @override
  _WindowStackState createState() => _WindowStackState();
}

class _WindowStackState extends State<WindowStack> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.insets,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double stackWidth = constraints.maxWidth;
          double stackHeight = constraints.maxHeight;

          return Stack(
            children: widget.wmController!.windows.map((e) {
              return _WindowStackItem(window: e, maxStackWH: Vector2(stackWidth, stackHeight), key: e.key);
            }).toList(),
          );
        },
      ),
    );
  }
}

/// A graphical UI window widget.
class _WindowStackItem extends StatefulWidget {
  final Window window;
  final Vector2 maxStackWH;

  const _WindowStackItem({Key? key, required this.window, required this.maxStackWH}) : super(key: key);

  @override
  _WindowStackItemState createState() => _WindowStackItemState();
}

// TODO: Handle new renders and update image
class _WindowStackItemState extends State<_WindowStackItem> with TickerProviderStateMixin {
  late Window e;

  late AnimationController animController;
  Curve defaultAnimCurve = Curves.linear;
  Duration defaultAnimDuration = Duration.zero;
  late Curve animCurve;
  late Duration animDuration;

  GlobalKey<_WindowContentState> wcontentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    e = widget.window;
    animController = AnimationController(vsync: this);
    animCurve = defaultAnimCurve;
    animDuration = defaultAnimDuration;
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  void _handleResizeCallback(Vector2 size) {
    if (animCurve != defaultAnimCurve) return;
    e.setSize(size);
  }

  void _handlePosCallback(Vector2 pos) {
    if (animCurve != defaultAnimCurve) return;
    e.setPos(pos);
  }

  void _handleStateCallback(WindowState state) {
    animCurve = Curves.easeInOut;
    animDuration = const Duration(milliseconds: 100);
    e.setState(state);
  }

  @override
  Widget build(BuildContext context) {
    WindowContent wcontent = WindowContent(key: wcontentKey, texture: e.render);

    WindowWidget wgt = WindowWidget(
      content: wcontent,
      windowBackgroundMode: e.bgRenderMode,
      windowIsFocused: e.isFocused,
      windowIsResizable: e.isResizable,
      windowPos: e.pos,
      windowSize: e.size,
      windowState: e.state,
      focusCallback: e.setFocus,
      resizeCallback: _handleResizeCallback,
      posCallback: _handlePosCallback,
      stateCallback: _handleStateCallback,
      closeCallback: e._close,
    );

    return AnimatedBuilder(
      animation: animController,
      builder: (context, widget_) {
        return AnimatedPositioned(
          onEnd: () {
            animCurve = defaultAnimCurve;
            animDuration = defaultAnimDuration;
          },
          duration: animDuration,
          curve: animCurve,
          left: e.pos.x,
          top: e.pos.y,
          width: e.size.x != double.infinity ? e.size.x : widget.maxStackWH.x,
          height: e.size.y != double.infinity ? e.size.y : widget.maxStackWH.y,
          key: wgt.key,
          child: wgt,
        );
      },
    );
  }
}