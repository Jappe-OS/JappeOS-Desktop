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

import 'package:flutter/material.dart';
import 'package:shade_theming/main.dart';

/// A simple base button.
class DeuiButtonBase extends StatefulWidget {
  /// The widget inside the button.
  final Widget? child;

  /// Controls the border radius of the button.
  final double? borderRadius;

  /// Set the padding of the button.
  final EdgeInsetsGeometry? padding;

  /// Sets the alignment of the button.
  final Alignment? alignment;

  /// The height of the button.
  final double? height;

  /// The width of the button.
  final double? width;

  /// The [Function] triggered when the button is pressed.
  final Function()? onPress;

  const DeuiButtonBase({Key? key, this.child, this.borderRadius, this.padding, this.alignment, this.height, this.width, this.onPress}) : super(key: key);

  @override
  _DeuiButtonBaseState createState() => _DeuiButtonBaseState();
}

/// The [State] class for [DeuiButtonBase].
class _DeuiButtonBaseState extends State<DeuiButtonBase> {
  @override
  Widget build(BuildContext context) {
    Color accentColor = ShadeTheme.getCurrentThemeProperties().accentColor;

    return Align(
      alignment: widget.alignment ?? Alignment.topLeft,
      child: Container(
        height: widget.height ?? 35,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius != null ? BorderRadius.circular(widget.borderRadius ?? 10) : null,
          color: accentColor.withOpacity(0.5),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            mouseCursor: SystemMouseCursors.alias,
            hoverColor: accentColor.withOpacity(0.1),
            splashColor: accentColor.withOpacity(0.25),
            highlightColor: accentColor.withOpacity(0.1),
            borderRadius: widget.borderRadius != null ? BorderRadius.circular(widget.borderRadius ?? 10) : null,
            onTap: widget.onPress,
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.all(0),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
