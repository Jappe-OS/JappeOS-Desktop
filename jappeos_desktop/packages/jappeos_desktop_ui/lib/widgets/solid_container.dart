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
import 'package:jappeos_desktop_ui/jappeos_desktop_ui.dart';
import 'package:jappeos_desktop_ui/widgets/blur_container.dart';
import 'package:shade_theming/main.dart';

/// A container with a solid background.
class DeuiSolidContainer extends StatefulWidget {
  /// The child inside the widget.
  final Widget child;

  /// Whether to show a border or not.
  final bool? bordered;

  /// The width of the widget.
  final double? width;

  /// The height of the widget.
  final double? height;

  /// Toggle border radius on different corners.
  final BorderRadiusSides? radiusSides;

  const DeuiSolidContainer({Key? key, required this.child, this.bordered, this.width, this.height, this.radiusSides}) : super(key: key);

  @override
  _DeuiSolidContainerState createState() => _DeuiSolidContainerState();
}

/// The [State] class for [DeuiSolidContainer].
class _DeuiSolidContainerState extends State<DeuiSolidContainer> {
  @override
  Widget build(BuildContext context) {
    Color borderColor = ShadeTheme.getTheme() == 0 ? const Color.fromARGB(77, 255, 255, 255) : const Color.fromARGB(77, 0, 0, 0);

    BorderRadiusGeometry brg = BorderRadius.only(
      topLeft: widget.radiusSides!.topLeft ? Radius.circular(JappeOsDesktopUI.getDefaultBorderRadius()) : Radius.zero,
      topRight: widget.radiusSides!.topRight ? Radius.circular(JappeOsDesktopUI.getDefaultBorderRadius()) : Radius.zero,
      bottomLeft: widget.radiusSides!.bottomLeft ? Radius.circular(JappeOsDesktopUI.getDefaultBorderRadius()) : Radius.zero,
      bottomRight: widget.radiusSides!.bottomRight ? Radius.circular(JappeOsDesktopUI.getDefaultBorderRadius()) : Radius.zero,
    );

    return ClipRRect(
      borderRadius: brg,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: brg,
          border: (widget.bordered ?? false) ? Border.all(width: 1.5, color: borderColor) : null,
          color: ShadeTheme.getCurrentThemeProperties().backgroundColor1,
        ),
        child: widget.child,
      ),
    );
  }
}
