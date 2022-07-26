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

class DE_BUTTON_Taskbar extends StatefulWidget {
  final VoidCallback onPress;
  final IconData icon;

  DE_BUTTON_Taskbar({Key? key, required this.onPress, required this.icon}) : super(key: key);

  _DE_BUTTON_TaskbarState createState() => _DE_BUTTON_TaskbarState();
}

class _DE_BUTTON_TaskbarState extends State<DE_BUTTON_Taskbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      margin: EdgeInsets.all(5),
      child: TextButton(
        child: Icon(widget.icon, color: Colors.white.withOpacity(0.85)),
        onPressed: widget.onPress,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )
          )
        )
      ),
    );
  }
}
