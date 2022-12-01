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
import 'package:shade_ui/theming.dart';
import 'package:shade_ui/widgets/base.dart';
import 'package:shade_ui/widgets/other/shade_icon.dart';
import 'package:shade_ui/widgets/text/shade_text.dart';

/// A button that can contain text or an icon, by ShadeUI.
class ShadeButton extends StatefulWidget {
  /// The [String] inside the button.
  final String? text;

  /// The [IconData] of the [Icon] inside the button.
  final IconData? icon;

  /// Whether the button is marked as the primary alternative.
  final bool? isPrimary;

  /// This [Function] is called when the button is pressed.
  final Function()? onPress;

  const ShadeButton({Key? key, this.text, this.icon, this.isPrimary, this.onPress}) : super(key: key);

  @override
  _ShadeButtonState createState() => _ShadeButtonState();
}

/// The [State] class for [ShadeButton].
class _ShadeButtonState extends State<ShadeButton> {
  Color backgroundColor = CurrentTheme.getCurrentThemeProperties().backgroundColor2;
  final Color accentColor = CurrentTheme.getCurrentThemeProperties().accentColor;

  Widget child() {
    final bool isPrimary = widget.isPrimary ?? false;

    bool text = widget.text != null;
    bool icon = widget.icon != null;

    Widget wText = ShadeText(
      text: widget.text ?? "null",
      customColor: isPrimary ? CurrentTheme.getCurrentThemeProperties().invertedTextColor : accentColor,
    );
    Widget wIcon = ShadeIcon(
      icon: widget.icon ?? Icons.error,
      customColor: isPrimary ? CurrentTheme.getCurrentThemeProperties().invertedTextColor : accentColor,
    );

    if (text && !icon) {
      return wText;
    } else if (icon && !text) {
      return wIcon;
    }

    return Row(
      children: [
        wIcon,
        wText,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = widget.isPrimary ?? false;

    backgroundColor = isPrimary ? accentColor : CurrentTheme.getCurrentThemeProperties().backgroundColor2;

    return ButtonBase(
        backgroundColor: backgroundColor, highlightColor: accentColor, hoverColor: accentColor, splashColor: accentColor, child: child());
  }
}
