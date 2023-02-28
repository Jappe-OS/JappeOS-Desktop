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

import 'package:flutter/material.dart';
import 'package:jappeos_desktop_ui/widgets/blur_container.dart';
import 'package:jappeos_desktop_ui/widgets/text.dart';

import 'bases/button_base_glasshover.dart';

/// A context menu area; opens a menu when right-clicked.
class DeuiContextMenuArea extends StatefulWidget {
  /// The context menu shown when right-clicking.
  final DeuiContextMenu contextMenu;

  const DeuiContextMenuArea({Key? key, required this.contextMenu}) : super(key: key);

  @override
  _DeuiContextMenuAreaState createState() => _DeuiContextMenuAreaState();
}

/// The [State] class for [DeuiContextMenuArea].
class _DeuiContextMenuAreaState extends State<DeuiContextMenuArea> {
  bool _showMenu = false;
  Offset _updatedMousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    if (_showMenu) stackChildren.add(Positioned(left: _updatedMousePosition.dx, top: _updatedMousePosition.dy, child: widget.contextMenu));

    return GestureDetector(
      onSecondaryTap: () => _showMenu = !_showMenu,
      child: MouseRegion(
        onHover: (event) => _updatedMousePosition = event.localPosition,
        child: Stack(
          children: stackChildren,
        ),
      ),
    );
  }
}

/// A context menu that can be assigned to a [DeuiContextMenuArea] widget.
class DeuiContextMenu extends StatefulWidget {
  /// A list of the items in the context menu.
  final List<DeuiContextMenuItem> items;

  const DeuiContextMenu({Key? key, required this.items}) : super(key: key);

  @override
  _DeuiContextMenuState createState() => _DeuiContextMenuState();
}

/// The [State] class for [DeuiContextMenu].
class _DeuiContextMenuState extends State<DeuiContextMenu> {
  @override
  Widget build(BuildContext context) {
    return DeuiBlurContainer(
      child: Column(children: widget.items,)
    );
  }
}

/// A context menu item with text.
class DeuiContextMenuItem extends StatefulWidget {
  /// The text.
  final String text;

  /// Called when the item is clicked.
  final Function()? onPress;

  const DeuiContextMenuItem({Key? key, required this.text, this.onPress}) : super(key: key);

  @override
  _DeuiContextMenuItemState createState() => _DeuiContextMenuItemState();
}

/// The [State] class for [DeuiContextMenuItem].
class _DeuiContextMenuItemState extends State<DeuiContextMenuItem> {
  @override
  Widget build(BuildContext context) {
    return DeuiButtonBaseGlasshover(
      height: 35,
      onPress: widget.onPress,
      child: DeuiText(isTitle: false, text: widget.text),
    );
  }
}
