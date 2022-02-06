import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jappeos_desktop/components/apps.dart';

import 'applications/settings/settings-redesign.dart';
import 'components/buttons/normal_buttons.dart';
import 'package:jappeos_desktop/components/consts.dart';

import 'components/cwidgets.dart';
import 'windowManager/wmcontroller.dart';
import 'windowManager/wmmanager.dart';

class Desktop extends StatefulWidget {
  Desktop({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DesktopState createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  
  WmController wmController;
  @override
  void initState() {
    super.initState();

    wmController = WmController(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(dsktpWallpaper), // desktop background image
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                child: Stack(
                  children: [
                    WmManager(
                      wmController: wmController,
                    ),
                  ]
                )
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 50,
              child: blurContainer(
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.all(5),
                              child: TextButton(
                                child: Icon(Icons.apps, color: Colors.white.withOpacity(0.85)),
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )
                                  )
                                )
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.all(5),
                              child: TextButton(
                                child: Icon(Icons.search, color: Colors.white.withOpacity(0.85)),
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )
                                  )
                                )
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.all(5),
                              child: TextButton(
                                child: Icon(Icons.tab, color: Colors.white.withOpacity(0.85)),
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )
                                  )
                                )
                              ),
                            ),
                            JNormalTextButton(
                              text: "Open settings",
                              onPress: () {
                                wmController.wm$spawn_gui_window(
                                  Apps.SETTINGS
                                );
                              },
                            ),
                          ]
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [

                          ]
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Blur effects
  Widget blurContainer(Widget child) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 1.2,
          color: dsktp_BLUR_COLOR,
          child: child,
        ),
      ),
    );
  }
}
