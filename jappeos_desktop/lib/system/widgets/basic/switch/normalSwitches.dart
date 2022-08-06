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

/// A normal boolean switch.
///
/// Made by Jappe. (2022)
class UI_NormalSwitches_NormalSwitch extends StatefulWidget {
  final void Function(bool)? onChanged;
  final bool value;

  UI_NormalSwitches_NormalSwitch({Key? key, required this.onChanged, required this.value}) : super(key: key);

  _NormalSwitch createState() => _NormalSwitch();
}

class _NormalSwitch extends State<UI_NormalSwitches_NormalSwitch> {
  @override
  Widget build(BuildContext context) {
    return new Switch(
      onChanged: widget.onChanged, 
      value: widget.value,
    );
  }
}
