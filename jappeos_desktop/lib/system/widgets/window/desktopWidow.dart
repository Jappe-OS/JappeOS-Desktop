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

class JDesktopWindow extends StatefulWidget {
  final String? windowTitle;
  final Widget? windowBody;

  JDesktopWindow({Key? key, this.windowTitle, this.windowBody})
      : super(key: key);

  _JDesktopWindow createState() => _JDesktopWindow();
}

class _JDesktopWindow extends State<JDesktopWindow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: blurContainer(
        Stack(
          children: [
            // Header
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 35,
              child: Row(
                children: [
                  Text(widget.windowTitle ?? ""),
                ],
              ),
            ),

            // Body
            Positioned(
              left: 0,
              right: 0,
              top: 35,
              bottom: 0,
              child: widget.windowBody ??
                  new Container(
                    color: Colors.transparent,
                  ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget blurContainer(Widget child) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
        child: Container(
          /*width: widget.currentWidth,
          height: _headerSize,*/
          color: Colors.white,
          child: child,
        ),
      ),
    );
  }
}
