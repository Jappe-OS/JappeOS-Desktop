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
class UITextNormalText extends StatefulWidget {
  final String text;

  const UITextNormalText({Key? key, required this.text}) : super(key: key);

  @override
  _NormalText createState() => _NormalText();
}

class _NormalText extends State<UITextNormalText> {
  @override
  Widget build(BuildContext context) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    return Text(
      widget.text,
      style: TextStyle(
        color: themeColorGetters.getTextColor(context, DesktopCfg$TextColorType.normal),
        fontSize: 15,
      ),
    );
  }
}
