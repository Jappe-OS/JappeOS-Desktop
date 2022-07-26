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
import 'package:jappeos_desktop/system/desktopCfg.dart';
import 'package:jappeos_desktop/system/widgets/desktop/desktopGeneral/buttons.dart';
import 'package:jappeos_desktop/system/widgets/generalWidgets.dart';

class DE_POPUP_Launcher extends StatefulWidget {
  DE_POPUP_Launcher({Key? key}) : super(key: key);

  _DE_POPUP_LauncherState createState() => _DE_POPUP_LauncherState();
}

class _DE_POPUP_LauncherState extends State<DE_POPUP_Launcher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(DesktopCfg.DESKTOPCFG_INSTANCE
                .dsktpWallpaper), // desktop background image
            fit: BoxFit.cover,
          ),
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 50,
              right: 0,
              child: blurContainer(
                Container(
                  alignment: Alignment.center,
                  width: 1100,
                  height: double.infinity,
                  margin: EdgeInsets.only(top: 30, bottom: 30),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 1100,
                        height: 40,
                        child: JAppMainSearchBox(jbgtext: "Click to search..."),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              height: 50,
              child: blurContainer(Row(
                children: [
                  DE_BUTTON_Taskbar(
                    icon: Icons.apps,
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )),
            ),
          ],
        ),
        /*child: blurContainer(
        Container(
          alignment: Alignment.center,
          width: 5000,
          height: double.infinity,
          margin: EdgeInsets.only(top: 30, bottom: 30),
          child: Column(

          ),
        ),
      ),*/
      ),
    );
  }

  // Blur effects
  Widget blurContainer(Widget child) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BLUR_COLOR_DARK,
          child: child,
        ),
      ),
    );
  }
}
