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
import 'package:jappeos_desktop/applications/settings/main.dart';
import 'package:jappeos_desktop/applications/terminal/main.dart';
import 'package:jappeos_desktop/applications/widgetTesting/main.dart';
import 'package:jappeos_desktop/desktop/desktopMenuManager/d_menu_controller.dart';
import 'package:jappeos_desktop/desktop/desktopMenuManager/d_menu_manager.dart';
import 'package:jappeos_desktop/system/appSystem/applications.dart';
import 'package:jappeos_desktop_ui/widgets/blur_container.dart';
import 'package:provider/provider.dart';
import 'package:jappeos_desktop_ui/widgets/button_base.dart';
import 'package:jappeos_desktop_ui/widgets/text.dart';
import 'package:shade_theming/main.dart';

import '../windowManager/wmcontroller.dart';
import '../windowManager/wmmanager.dart';

/// Fields that can be used in the desktop UI.
class _DesktopThemeProperties {
  /// Whether to render GUI on the desktop or not, if false, only the WM windows will be rendered.
  static bool renderGUI = true;

  /// The wallpaper of the desktop background.
  static String wallpaperAssetDir = "resources/images/desktop/backgrounds/wallpaper2.jpg";
}

/// The stateful widget for the base desktop UI.
class Desktop extends StatefulWidget {
  const Desktop({Key? key}) : super(key: key);

  @override
  DesktopState createState() => DesktopState();
}

/// This is the public class for the JappeOS Desktop, the `wmController` object can be accessed for using the windowing system.
///
/// See [WmController] for more information on the windowing system.
class DesktopState extends State<Desktop> {
  // Create a new instance of [WmController].
  static WmController? _wmController;
  static WmController? getWmController() {
    return _wmController;
  }

  // Create a new instance of [DesktopMenu$Controller].
  static DesktopMenu$Controller? _desktopMenuController;

  @override
  void initState() {
    super.initState();

    _wmController = WmController(() {
      setState(() {});
    });

    _desktopMenuController = DesktopMenu$Controller(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // The window layer of the desktop UI.
    final Widget windowLayer = Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Stack(
        children: [
          WmManager(
            wmController: _wmController,
          ),
        ],
      ),
    );

    // This is the dock, it is shown in the bottom of the screen.
    final Widget dock = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 10),
        child: IntrinsicWidth(
          child: DeuiBlurContainer(
            gradient: true,
            bordered: true,
            radiusSides: BorderRadiusSides(true, true, true, true),
            child: Row(
              children: [
                _DesktopWidgets._dockItem(null, () {}),
                _DesktopWidgets._dockItem(null, () {}),
                _DesktopWidgets._dockItem(null, () {}),
                _DesktopWidgets._dockItem(null, () {}),
              ],
            ),
          ),
        ),
      ),
    );

    // This is the topBar, it is shown in the top of the screen. It can be used to launch apps, or using the quickSettings menu.
    final Widget topBar = Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 30,
      child: DeuiBlurContainer(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // The items on the TopBar on the left side.
                children: [
                  // Launcher button.
                  _DesktopWidgets._topBarItem(null, _DesktopWidgets._topBarItemIcon(Icons.apps), true, () {}),
                  const SizedBox(width: 5),
                  // TaskView button.
                  _DesktopWidgets._topBarItem(null, _DesktopWidgets._topBarItemIcon(Icons.menu_open), true, () {}),
                  const SizedBox(width: 5),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // The items on the TopBar on the right side.
                children: [
                  // System tray buttons.
                  _DesktopWidgets._topBarItem(null, Row(children: [_DesktopWidgets._topBarItemIcon(Icons.mic), const SizedBox(width: 3), _DesktopWidgets._topBarItemIcon(Icons.camera)]), true, () {}),
                  const SizedBox(width: 5),
                  // QuickSettings button.
                  _DesktopWidgets._topBarItem(null, Row(children: [_DesktopWidgets._topBarItemIcon(Icons.wifi), const SizedBox(width: 3), _DesktopWidgets._topBarItemIcon(Icons.volume_mute), const SizedBox(width: 3), _DesktopWidgets._topBarItemIcon(Icons.battery_full)]), true, () {}),
                  const SizedBox(width: 5),
                  // Notifications and Time&Date button.
                  _DesktopWidgets._topBarItem(null, Row(children: [const DeuiText(isTitle: false, text: "19:00"), const SizedBox(width: 3), _DesktopWidgets._topBarItemIcon(Icons.notifications)]), true, () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // Desktop UI.
    return !_DesktopThemeProperties.renderGUI
        ? windowLayer
        : Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  // The desktop background image.
                  image: AssetImage(_DesktopThemeProperties.wallpaperAssetDir),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  windowLayer,

                  // The desktop-menu layer of the desktop.
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Stack(
                      children: [
                        DesktopMenu$Manager(
                          dmController: _desktopMenuController,
                        ),
                      ],
                    ),
                  ),

                  // The dock shown in the bottom of the desktop UI.
                  dock,

                  // This is the TopBar, it's shown on the top of the desktop UI.
                  topBar,
                ],
              ),
            ),
          );
  }
}

/// A class that contains all the desktop widgets like the TopBar buttons, Dock items, etc.
class _DesktopWidgets {
  /// The item element(s) that will be shown in the dock.
  static Widget _dockItem(ImageProvider? img, Function() onPressed) {
    return DeuiButtonBase(
      height: 80,
      width: 80,
      onPress: onPressed,
      child: Padding(padding: const EdgeInsets.all(8.0), child: Image(image: img ?? const AssetImage("resources/images/null.png"),),),
    );
  }

  /// The item element(s) used in the topBar widget.
  static Widget _topBarItem(String? text, Widget? customWidget, bool custom, Function()? onPressed) {
    return DeuiButtonBase(
      height: 30,
      onPress: onPressed,
      child: custom ? customWidget : DeuiText(isTitle: false, text: text ?? "null"),
    );
  }

  /// The icons used in the [_topBarItem] element.
  static Widget _topBarItemIcon(IconData iconData) {
    return Icon(
      iconData,
      size: 17,
      color: ShadeTheme.getCurrentThemeProperties().normalTextColor,
    );
  }
}

// TODO: Rewrite overlay system.
/// Contains the overlay menus for the desktop UI, for example, the launcher.
///
/// Menus:
/// - 0 = Launcher
/// - 1 = TaskView
/// - 2 = QuickSettings
/*class DesktopOverlayMenus extends StatelessWidget {
  final DesktopMenu$Menus menu; // DesktopMenu$Menus.launcher
  final BuildContext uContext;

  const DesktopOverlayMenus(this.menu, {Key? key, required this.uContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (menu) {
      case DesktopMenu$Menus.launcher:
        return _launcher();
      case DesktopMenu$Menus.taskView:
        return _taskView();
      case DesktopMenu$Menus.quickSettings:
        return _quickSettings();
    }
  }

  // The UI for the launcher.
  Widget _launcher() {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(uContext);

    double width = 1200;

    return Column(
      children: [
        // Search bar.
        Container(
          width: width,
          height: 50,
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.only(left: 100, right: 100, top: 6),
          color: Colors.red,
          child: const UINormalTextFieldsTextField(
            hintText: "Search apps...",
            autoFocus: true,
          ),
        ),

        // App view.
        Container(
          width: width,
          height: MediaQuery.of(uContext).size.height - 350,
          margin: const EdgeInsets.only(top: 25, bottom: 25),
          color: Colors.green,
        ),

        // Buttons.
        Container(
          width: width,
          height: 50,
          color: Colors.blue,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Row(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: themeColorGetters.getCurrentAccentColor(),
                      backgroundColor: themeColorGetters.getBackgroundColor(uContext, DesktopCfg$BackgroundColorType.normal).withOpacity(0.5),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(width: 0.0, style: BorderStyle.none),
                        borderRadius: BorderRadius.zero,
                      ),
                      enabledMouseCursor: SystemMouseCursors.alias,
                      disabledMouseCursor: SystemMouseCursors.alias,
                    ),
                    onPressed: () {},
                    child: Icon(
                      Icons.power,
                      color: themeColorGetters.getCurrentAccentColor(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // The UI for the taskView.
  Widget _taskView() {
    return Container();
  }

  // The UI for the quickSettings.
  Widget _quickSettings() {
    return Container();
  }
}
*/