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

/// A normal-sized text widget.
class UIBasesButtonBase extends StatefulWidget {
  final Widget child;
  final Function()? onPress;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? background;
  final double? radiusAmount;

  const UIBasesButtonBase({Key? key, required this.child, required this.onPress, this.height, this.padding, this.background, this.radiusAmount}) : super(key: key);

  @override
  _ButtonBase createState() => _ButtonBase();
}

class _ButtonBase extends State<UIBasesButtonBase> {
  @override
  Widget build(BuildContext context) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);
    final Color accent = themeColorGetters.getCurrentAccentColor();

    return Container(
      height: widget.height ?? 35,
      decoration: BoxDecoration(
        borderRadius: widget.radiusAmount == null ? null : BorderRadius.circular(widget.radiusAmount ?? 4.5),
        color: widget.background,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          mouseCursor: SystemMouseCursors.alias,
          hoverColor: accent.withOpacity(0.1),
          splashColor: accent.withOpacity(0.25),
          highlightColor: accent.withOpacity(0.1),
          borderRadius: widget.radiusAmount == null ? null : BorderRadius.circular(widget.radiusAmount ?? 4.5),
          onTap: widget.onPress,
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.all(5),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
