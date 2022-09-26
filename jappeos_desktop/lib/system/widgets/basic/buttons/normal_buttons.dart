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
import 'package:jappeos_desktop/system/desktop_cfg.dart';
import 'package:provider/provider.dart';

/// A primary highlighted button with text.
class UINormalButtonsPrimaryTextButton extends StatefulWidget {
  final String text;
  final void Function()? onPress;

  const UINormalButtonsPrimaryTextButton({Key? key, required this.text, this.onPress}) : super(key: key);

  @override
  _PrimaryTextButton createState() => _PrimaryTextButton();
}

class _PrimaryTextButton extends State<UINormalButtonsPrimaryTextButton> {
  @override
  Widget build(BuildContext context) {
    //final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    return _ButtonBase.base(
      context,
      true,
      Text(
        widget.text,
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      widget.onPress,
    );

    /*return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: themeColorGetters.getCurrentAccentColor(),
        backgroundColor: themeColorGetters.getBackgroundColor(context, DesktopCfg$BackgroundColorType.brighter),
        side: BorderSide(
          width: 0.7,
          color: themeColorGetters.getBorderColor(context),
        ),
        enabledMouseCursor: SystemMouseCursors.alias,
        disabledMouseCursor: SystemMouseCursors.alias,
      ),
      onPressed: widget.onPress,
      child: Text(
        widget.text,
        style: TextStyle(color: themeColorGetters.getCurrentAccentColor()),
      ),
    );*/
  }
}

/// A secondary non-highlighted button with text.
class UINormalButtonsSecondaryTextButton extends StatefulWidget {
  final String text;
  final void Function()? onPress;

  const UINormalButtonsSecondaryTextButton({Key? key, required this.text, this.onPress}) : super(key: key);

  @override
  _SecondaryTextButton createState() => _SecondaryTextButton();
}

class _SecondaryTextButton extends State<UINormalButtonsSecondaryTextButton> {
  @override
  Widget build(BuildContext context) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    return _ButtonBase.base(
      context,
      false,
      Text(
        widget.text,
        style: TextStyle(color: themeColorGetters.getTextColor(context, DesktopCfg$TextColorType.normal), fontSize: 14, fontWeight: FontWeight.w500),
      ),
      widget.onPress,
    );

    /*return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: themeColorGetters.getCurrentAccentColor(),
        side: BorderSide(width: 0.7, color: themeColorGetters.getBorderColor(context)),
        enabledMouseCursor: SystemMouseCursors.alias,
        disabledMouseCursor: SystemMouseCursors.alias,
      ),
      onPressed: widget.onPress,
      child: Text(
        widget.text,
        style: TextStyle(color: themeColorGetters.getTextColor(context, DesktopCfg$TextColorType.normal)),
      ),
    );*/
  }
}

// The base widget for a button
class _ButtonBase {
  static Widget base(BuildContext context, bool accentBackground, Widget child, Function()? onPress) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);
    final Color accent = themeColorGetters.getCurrentAccentColor();

    const double borderRadius = 4.5;

    return Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          width: 0.7,
          color: themeColorGetters.getBorderColor(context),
        ),
        color: accentBackground ? themeColorGetters.getCurrentAccentColor() : themeColorGetters.getBackgroundColor(context, DesktopCfg$BackgroundColorType.brighter),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          mouseCursor: SystemMouseCursors.alias,
          hoverColor: accentBackground ? Colors.white.withOpacity(0.1) : accent.withOpacity(0.1),
          splashColor: accentBackground ? Colors.white.withOpacity(0.25) : accent.withOpacity(0.25),
          highlightColor: accentBackground ? Colors.white.withOpacity(0.1) : accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPress,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 6, bottom: 6, right: 15),
            child: child,
          ),
        ),
      ),
    );
  }
}
