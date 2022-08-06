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

/// A normal-sized text widget.
///
/// Made by Jappe. (2022)
class UI_Text_NormalText extends StatefulWidget {
  final String text;

  UI_Text_NormalText({Key? key, required this.text}) : super(key: key);

  _NormalText createState() => _NormalText();
}

class _NormalText extends State<UI_Text_NormalText> {
  @override
  Widget build(BuildContext context) {
    return new Text(
      widget.text
    );
  }
}
