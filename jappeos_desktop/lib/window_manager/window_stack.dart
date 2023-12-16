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

  const WindowStack({Key? key, this.wmController}) : super(key: key);

  @override
  _WindowStackState createState() => _WindowStackState();
}

class _WindowStackState extends State<WindowStack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.wmController!.windows.map((e) {
        return _WindowStackItem(window: e);
      }).toList(),
    );
  }
}

class _WindowStackItem extends StatefulWidget {
  final Window window;

  const _WindowStackItem({Key? key, required this.window}) : super(key: key);

  @override
  _WindowStackItemState createState() => _WindowStackItemState();
}

// TODO: Handle new renders and update image
class _WindowStackItemState extends State<_WindowStackItem> {
  late Window e;

  @override
  void initState() {
    super.initState();
    e = widget.window;
  }

  @override
  Widget build(BuildContext context) {
    WindowWidget wgt = WindowWidget(
      content: WindowContent(texture: Uint8List(0)),
      windowBackgroundMode: e.bgRenderMode,
      windowIsFocused: e.isFocused,
      windowIsResizable: e.isResizable,
      windowPos: e.pos,
      windowState: e.state,
      resizeCallback: e.setSize,
      posCallback: e.setPos,
      stateCallback: e.setState,
      closeCallback: e._close,
    );

    e.onEvent.subscribe((args) {
      if (args!.id != "onNewRender") setState(() {});
    });

    return Positioned(
      left: e.pos.x,
      top: e.pos.y,
      width: e.size.x,
      height: e.size.y,
      key: wgt.key,
      child: wgt,
    );
  }
}
