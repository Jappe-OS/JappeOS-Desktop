import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jappeos_desktop/components/appSystem/applications.dart';
import 'package:jappeos_desktop/components/widgets/buttons/normal_buttons.dart';

import 'package:jappeos_desktop/components/desktopCfg.dart';
import 'package:jappeos_desktop/components/widgets/desktopGeneral/buttons.dart';
import 'package:jappeos_desktop/components/widgets/desktopPopups/launcher.dart';

import 'windowManager/wmcontroller.dart';
import 'windowManager/wmmanager.dart';

class Desktop extends StatefulWidget {
  Desktop({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  DesktopState createState() => DesktopState();
}

class DesktopState extends State<Desktop> {
  static WmController? wmController;

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
            image: AssetImage(DesktopCfg.DESKTOPCFG_INSTANCE.dsktpWallpaper), // desktop background image
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
                  child: Stack(children: [
                WmManager(
                  wmController: wmController,
                ),
              ])),
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
                        child: Row(children: [
                          DE_BUTTON_Taskbar(
                            icon: Icons.apps,
                            onPress: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new DE_POPUP_Launcher()),
                              );
                            },
                          ),
                          DE_BUTTON_Taskbar(
                            icon: Icons.search,
                            onPress: () {},
                          ),
                          DE_BUTTON_Taskbar(
                            icon: Icons.tab,
                            onPress: () {},
                          ),
                          JNormalTextButton(
                            text: "Open Settings",
                            onPress: () {
                              Applications.sys$runProcess(Apps.SYSTEM_Settings);
                            },
                          ),
                        ]),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(children: []),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(children: []),
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
          color: DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BLUR_COLOR_DARK,
          child: child,
        ),
      ),
    );
  }
}
