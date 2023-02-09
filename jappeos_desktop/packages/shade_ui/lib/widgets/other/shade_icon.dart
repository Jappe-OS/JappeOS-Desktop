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
import 'package:provider/provider.dart';
import 'package:shade_theming/main.dart';

/// A simple icon element.
class ShadeIcon extends StatefulWidget {
  /// The icon.
  final IconData icon;

  /// The size of the icon.
  final double? size;

  /// The custom color of the icon.
  final Color? customColor;

  const ShadeIcon({Key? key, required this.icon, this.size, this.customColor}) : super(key: key);

  @override
  _ShadeIconState createState() => _ShadeIconState();
}

/// The [State] class for [ShadeIcon].
class _ShadeIconState extends State<ShadeIcon> {
  @override
  Widget build(BuildContext context) {
    final Color color = context.watch<ShadeThemeProvider>().getCurrentThemeProperties().accentColor;

    return Icon(
      widget.icon,
      color: widget.customColor ?? color,
      size: widget.size,
    );
  }
}
