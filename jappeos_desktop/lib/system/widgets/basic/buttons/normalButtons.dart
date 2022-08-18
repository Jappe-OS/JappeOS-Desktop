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

/// A primary highlighted button with text.
///
/// Made by Jappe. (2022)
class UI_NormalButtons_PrimaryTextButton extends StatefulWidget {
  final String text;
  final void Function()? onPress;

  UI_NormalButtons_PrimaryTextButton({Key? key, required this.text, this.onPress}) : super(key: key);

  _PrimaryTextButton createState() => _PrimaryTextButton();
}

class _PrimaryTextButton extends State<UI_NormalButtons_PrimaryTextButton> {
  @override
  Widget build(BuildContext context) {
    return new OutlinedButton(
      child: Text(
        widget.text,
        style: TextStyle(
            color: DesktopCfg.DESKTOPCFG_INSTANCE.getCurrentJappeOsAccentColorAsColor(context)),
      ),
      style: OutlinedButton.styleFrom(
        primary: DesktopCfg.DESKTOPCFG_INSTANCE.getCurrentJappeOsAccentColorAsColor(context),
        backgroundColor: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context) ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_DARK_SECONDARY : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_LIGHT_SECONDARY,
        side: BorderSide(width: 0.7, color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context) ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BORDER_COLOR_DARK : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BORDER_COLOR_LIGHT),
        enabledMouseCursor: SystemMouseCursors.alias,
        disabledMouseCursor: SystemMouseCursors.alias,
      ),
      onPressed: widget.onPress,
    );
  }
}


/// A secondary non-highlighted button with text.
///
/// Made by Jappe. (2022)
class UI_NormalButtons_SecondaryTextButton extends StatefulWidget {
  final String text;
  final void Function()? onPress;

  UI_NormalButtons_SecondaryTextButton({Key? key, required this.text, this.onPress}) : super(key: key);

  _SecondaryTextButton createState() => _SecondaryTextButton();
}

class _SecondaryTextButton extends State<UI_NormalButtons_SecondaryTextButton> {
  @override
  Widget build(BuildContext context) {
    return new OutlinedButton(
      child: Text(
        widget.text,
        style: TextStyle(
          color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
              ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_DARK.withOpacity(0.6)
              : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_LIGHT.withOpacity(0.6)
        ),
      ),
      style: OutlinedButton.styleFrom(
        primary: DesktopCfg.DESKTOPCFG_INSTANCE.getCurrentJappeOsAccentColorAsColor(context),
        side: BorderSide(width: 0.7, color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context) ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BORDER_COLOR_DARK : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BORDER_COLOR_LIGHT),
        enabledMouseCursor: SystemMouseCursors.alias,
        disabledMouseCursor: SystemMouseCursors.alias,
      ),
      onPressed: widget.onPress,
    );
  }
}
