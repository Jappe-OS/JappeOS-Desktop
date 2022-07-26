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

// JAPPEOS NORMAL BUTTON - TEXT

class JNormalTextButton extends StatefulWidget {
  final VoidCallback onPress;
  final String text;

  JNormalTextButton({Key? key, required this.onPress, required this.text})
      : super(key: key);

  _JNormalTextButton createState() => _JNormalTextButton();
}

class _JNormalTextButton extends State<JNormalTextButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        widget.text,
        style: TextStyle(
            color: DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_LIGHT),
      ),
      style: ElevatedButton.styleFrom(
        primary: DesktopCfg.DESKTOPCFG_INSTANCE
            .getJappeosThemeColor(JappeOsColor.DEFAULT),
      ),
      onPressed: widget.onPress,
    );
  }
}

// JAPPEOS NORMAL BUTTON - TEXT

class JSecondaryTextButton extends StatefulWidget {
  final VoidCallback onPress;
  final String text;

  JSecondaryTextButton({Key? key, required this.onPress, required this.text})
      : super(key: key);

  _JSecondaryTextButton createState() => _JSecondaryTextButton();
}

class _JSecondaryTextButton extends State<JSecondaryTextButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        widget.text,
        style: TextStyle(
            color: DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_DARK),
      ),
      style: ElevatedButton.styleFrom(
        primary: DesktopCfg.DESKTOPCFG_INSTANCE
            .getJappeosThemeColor(JappeOsColor.DEFAULT),
      ),
      onPressed: widget.onPress,
    );
  }
}
