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
import 'package:jappeos_desktop/desktop/desktopMenuManager/d_menu_controller.dart';

class DesktopMenu$Manager extends StatefulWidget {

  final DesktopMenu$Controller? dmController;

  const DesktopMenu$Manager({Key? key, this.dmController}) : super(key: key);

  @override
  _MenuManagerState createState() => _MenuManagerState();
}

class _MenuManagerState extends State<DesktopMenu$Manager> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.dmController!.menuWindows.map((e){
        return Positioned(
          left: e.x,
          top: e.y,
          key: e.key,
          child: e,
        );
      }).toList()
    );
  }
}