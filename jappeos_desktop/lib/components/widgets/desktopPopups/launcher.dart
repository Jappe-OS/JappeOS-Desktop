import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jappeos_desktop/components/consts.dart';
import 'package:jappeos_desktop/components/widgets/desktopGeneral/buttons.dart';
import 'package:jappeos_desktop/components/widgets/generalWidgets.dart';

class DE_POPUP_Launcher extends StatefulWidget {
  DE_POPUP_Launcher({Key key}) : super(key: key);

  _DE_POPUP_LauncherState createState() => _DE_POPUP_LauncherState();
}

class _DE_POPUP_LauncherState extends State<DE_POPUP_Launcher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(dsktpWallpaper), // desktop background image
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
                padding: EdgeInsets.only(left: 10, right: 10,),
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
          color: dsktp_BLUR_COLOR_DARK,
          child: child,
        ),
      ),
    );
  }
}
