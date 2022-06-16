import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jappeos_desktop/applications/settings/main.dart';
import 'package:jappeos_desktop/system/appSystem/applications.dart';
import 'package:jappeos_desktop/system/desktopCfg.dart';

import 'windowManager/wmcontroller.dart';
import 'windowManager/wmmanager.dart';

/// The stateful widget for the base desktop UI.
/// 
/// Made by Jappe. (2022)
class Desktop extends StatefulWidget {
  Desktop({Key? key}) : super(key: key);

  @override
  DesktopState createState() => DesktopState();
}

/// This is the public class for the JappeOS Desktop, the `wmController` object can be accessed for using the windowing system. 
/// 
/// See [WmController] for more information on the windowing system.
/// 
/// Made by Jappe. (2022)
class DesktopState extends State<Desktop> {
  // Create a new instance of [WmController].
  static WmController? wmController;

  // The padding on the left and right side of the TopBar element.
  final double _TOP_BAR_sidePadding = 5;
  // The icon size for Icons on the TopBar buttons.
  final double _TOP_BAR_buttonIconSize = 17;
  // The icon/text color for TopBar buttons.
  final Color _TOP_BAR_buttonOverlayColor = Colors.white;

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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            // The desktop background image.
            image: AssetImage(DesktopCfg.DESKTOPCFG_INSTANCE.dsktpWallpaper),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // The background layer of the desktop UI.
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

            // The dock shown in the bottom of the dekstop UI.
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[_basicShadow()],
                ),
                child: IntrinsicWidth(
                  child: _blurContainer(
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      // The items shown in the dock.
                      children: [
                        _dockItem(null, null, false, () {
                          Applications.sys$runProcess(new Settings());
                        }),
                        _dockItem(null, null, false, () {}),
                        _dockItem(null, null, false, () {}),
                        _dockItem(null, null, false, () {}),
                      ],
                    ),
                  true),
                ),
              ),
            ),

            // This is the TopBar, it's whown on the top of the desktop UI.
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 30,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[_basicShadow()],
                ),
                child: _blurContainer(
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: _TOP_BAR_sidePadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          // The items on the TopBar on the left side.
                          children: [
                            _topBarItem(
                                null,
                                () {},
                                true,
                                new Container(
                                  child: Icon(
                                    Icons.apps,
                                    size: _TOP_BAR_buttonIconSize,
                                    color: _TOP_BAR_buttonOverlayColor,
                                  ),
                                )),
                            SizedBox(width: 5),
                            _topBarItem(
                                null,
                                () {},
                                true,
                                new Container(
                                  child: Icon(
                                    Icons.menu_open,
                                    size: _TOP_BAR_buttonIconSize,
                                    color: _TOP_BAR_buttonOverlayColor,
                                  ),
                                )),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: _TOP_BAR_sidePadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          // The items on the TopBar on the right side.
                          children: [
                            _topBarItem(
                                null,
                                () {},
                                true,
                                new Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.mic,
                                        size: _TOP_BAR_buttonIconSize,
                                        color: _TOP_BAR_buttonOverlayColor,
                                      ),
                                      SizedBox(width: 3),
                                      Icon(
                                        Icons.camera,
                                        size: _TOP_BAR_buttonIconSize,
                                        color: _TOP_BAR_buttonOverlayColor,
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(width: 5),
                            _topBarItem(
                                null,
                                () {},
                                true,
                                new Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.wifi,
                                        size: _TOP_BAR_buttonIconSize,
                                        color: _TOP_BAR_buttonOverlayColor,
                                      ),
                                      SizedBox(width: 3),
                                      Icon(
                                        Icons.volume_mute,
                                        size: _TOP_BAR_buttonIconSize,
                                        color: _TOP_BAR_buttonOverlayColor,
                                      ),
                                      SizedBox(width: 3),
                                      Icon(
                                        Icons.battery_full,
                                        size: _TOP_BAR_buttonIconSize,
                                        color: _TOP_BAR_buttonOverlayColor,
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(width: 5),
                            _topBarItem(
                                null,
                                () {},
                                true,
                                new Container(
                                  child: Row(
                                    children: [
                                      Text('19:00', style: TextStyle(color: _TOP_BAR_buttonOverlayColor,)),
                                      SizedBox(width: 3),
                                      Icon(
                                        Icons.notifications,
                                        size: _TOP_BAR_buttonIconSize,
                                        color: _TOP_BAR_buttonOverlayColor,
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ), false
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Blur effects
  Widget _blurContainer(Widget child, bool radius) {
    final BackdropFilter _bf = new BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        child: child,
        decoration: BoxDecoration(
          color: DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BLUR_COLOR_DARK,
        ),
      ),
    );

    if (radius) {
      return ClipRRect(
        child: _bf,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      );
    } else {
      return ClipRRect(
        child: _bf,
      );
    }
  }

  // Top Bar Item
  Widget _topBarItem(String? text, Function()? onPressed, bool custom, Widget? customWidget) {
    if (!custom) {
      return Container(
        child: TextButton(
            child: Text(text ?? "", style: TextStyle(color: _TOP_BAR_buttonOverlayColor,)),
            style: TextButton.styleFrom(
              minimumSize: Size(30, 30),
              padding: EdgeInsets.all(6),
              enabledMouseCursor: SystemMouseCursors.alias,
              disabledMouseCursor: SystemMouseCursors.alias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onPressed),
      );
    } else {
      return Container(
        child: TextButton(
            child: customWidget ?? new Container(),
            style: TextButton.styleFrom(
              minimumSize: Size(30, 30),
              padding: EdgeInsets.all(6),
              enabledMouseCursor: SystemMouseCursors.alias,
              disabledMouseCursor: SystemMouseCursors.alias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onPressed),
      );
    }
  }

  // Dock Item
  Widget _dockItem(ImageProvider? img, IconData? icon, bool isIcon, Function() onPressed) {
    if (!isIcon) {
      return _dockItemBase(
          Image(
            image: img ?? AssetImage("lib/images/null.png"),
          ),
          onPressed);
    } else {
      return _dockItemBase(
          Icon(
            icon,
            size: 40,
          ),
          onPressed);
    }
  }

  Widget _dockItemBase(Widget child, Function() onPressed) {
    return Container(
      width: 70,
      height: 70,
      margin: EdgeInsets.all(5),
      child: TextButton(
          child: child,
          onPressed: onPressed,
          style: TextButton.styleFrom(
            enabledMouseCursor: SystemMouseCursors.alias,
            disabledMouseCursor: SystemMouseCursors.alias,
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
    );
  }

  // Shadow element for TopBar and the Dock.
  BoxShadow _basicShadow() {
    return BoxShadow(
      color: Colors.black,
      offset: Offset(0, 0),
      blurRadius: 10.0,
    );
  }
}
