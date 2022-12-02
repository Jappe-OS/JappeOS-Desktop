//  ShadeUI, An UI elements package for JappeOS apps.
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
import 'package:shade_theming/main.dart';
import 'package:shade_ui/utils.dart';

/// The base button widget, any color other than [backgroundColor] should not be transparent because that's already determined by this class.
class ButtonBase extends StatefulWidget {
  /// The widget inside the button itself.
  final Widget child;

  /// The color of the button background.
  final Color backgroundColor;

  /// Color of the button when highlighted, no transparency needed.
  final Color highlightColor;

  /// Color of the button when hovered, no transparency needed.
  final Color hoverColor;

  /// Color of the button material splash effect, no transparency needed.
  final Color splashColor;

  /// The height of the button. If null, default height will be used.
  final double? height;

  /// The padding of the button content; the empty space around the [child] widget.
  final EdgeInsetsGeometry? padding;

  /// The alignment of the button.
  final Alignment? alignment;

  /// The [Function] is called when the button is pressed.
  final Function()? onPress;

  const ButtonBase(
      {Key? key,
      required this.child,
      required this.backgroundColor,
      required this.highlightColor,
      required this.hoverColor,
      required this.splashColor,
      this.height,
      this.padding,
      this.alignment,
      this.onPress})
      : super(key: key);

  @override
  _ButtonBaseState createState() => _ButtonBaseState();
}

/// The [State] class for [ButtonBase].
class _ButtonBaseState extends State<ButtonBase> {
  @override
  Widget build(BuildContext context) {
    final double height = widget.height ?? Utils.getSigleLineElementHeight();
    final BorderRadius br = BorderRadius.circular(Utils.getDefaultBorderRadius());

    return Align(
      alignment: widget.alignment ?? Alignment.topLeft,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: br,
          border: Border.all(
            width: 0.7,
            color: ShadeTheme.getCurrentThemeProperties().borderColor,
          ),
          color: widget.backgroundColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            mouseCursor: SystemMouseCursors.alias,
            hoverColor: widget.hoverColor.withOpacity(0.1),
            splashColor: widget.splashColor.withOpacity(0.25),
            highlightColor: widget.highlightColor.withOpacity(0.1),
            borderRadius: br,
            onTap: widget.onPress,
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.all(5),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
