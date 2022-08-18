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
import 'package:jappeos_desktop/system/desktopCfg.dart';

/// A normal text-field.
///
/// Made by Jappe. (2022)
class UI_NormalTextFields_TextField extends StatefulWidget {
  final String? hintText;
  final bool? autoFocus;
  final bool? readOnly;

  UI_NormalTextFields_TextField({Key? key, this.hintText, this.autoFocus, this.readOnly}) : super(key: key);

  _TextField createState() => _TextField();
}

class _TextField extends State<UI_NormalTextFields_TextField> {
  @override
  Widget build(BuildContext context) {
    return new TextField(
      autofocus: widget.autoFocus ?? false,
      readOnly: widget.readOnly ?? false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(7.5),
        isDense: true,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.7, color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context) ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BORDER_COLOR_DARK : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BORDER_COLOR_LIGHT)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.7, color: DesktopCfg.DESKTOPCFG_INSTANCE.getCurrentJappeOsAccentColorAsColor(context))),
      ),
    );
  }
}
