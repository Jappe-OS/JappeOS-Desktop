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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jappeos_desktop/system/desktop_cfg.dart';
import 'package:provider/provider.dart';

/// A container that has a [BackdropFilter] with a blur effect.
class UIBlurContainer extends StatefulWidget {
  final Widget child;
  final bool? radius;
  final double? radiusAmount;

  const UIBlurContainer({Key? key, required this.child, this.radius, this.radiusAmount}) : super(key: key);

  @override
  _BlurContainer createState() => _BlurContainer();
}

class _BlurContainer extends State<UIBlurContainer> {
  @override
  Widget build(BuildContext context) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    final bool radius = widget.radius ?? false;

    final BackdropFilter bf = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          color: themeColorGetters.getBackgroundColor(context, DesktopCfg$BackgroundColorType.normal).withOpacity(0.5),
        ),
        child: widget.child,
      ),
    );

    if (radius) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.radiusAmount ?? 5.0)),
        child: bf,
      );
    } else {
      return ClipRRect(
        child: bf,
      );
    }
  }
}
