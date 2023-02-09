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

/// A simple switch that can be toggled on and off, by ShadeUI.
class ShadeSwitch extends StatefulWidget {
  /// The default value of the switch.
  final bool value;

  /// This [Function] is triggered when the value of the switch has changed.
  final void Function(bool)? onChanged;

  const ShadeSwitch({Key? key, required this.value, this.onChanged}) : super(key: key);

  @override
  _ShadeSwitchState createState() => _ShadeSwitchState();
}

/// The [State] class for [ShadeSwitch].
class _ShadeSwitchState extends State<ShadeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: widget.onChanged,
      value: widget.value,
      mouseCursor: SystemMouseCursors.alias,
      activeColor: context.watch<ShadeThemeProvider>().getCurrentThemeProperties().accentColor,
      activeTrackColor: context.watch<ShadeThemeProvider>().getCurrentThemeProperties().accentColor.withOpacity(0.5),
    );
  }
}
