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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jappeos_desktop/applications/appMaker/main.dart';
import 'package:jappeos_desktop/applications/terminal/main.dart';
import 'package:jappeos_desktop/applications/test/main.dart';
import 'package:jappeos_desktop/applications/widgetTesting/main.dart';
import 'package:jappeos_desktop/desktop/desktopMenuManager/desktop_menu_controller.dart';
import 'package:jappeos_desktop_ui/jappeos_desktop_ui.dart';
import 'package:jappeos_desktop_ui/widgets/bases/button_base_glasshover.dart';
import 'package:jappeos_desktop_ui/widgets/blur_container.dart';
import 'package:jappeos_desktop_ui/widgets/context_menu.dart';
import 'package:jappeos_desktop_ui/widgets/text.dart';
import 'package:shade_theming/shade_theming.dart';

import '../applications/settings/main.dart';
import '../system/appSystem/applications.dart';
import '../windowManager/wmcontroller.dart';
import '../windowManager/wmmanager.dart';
import 'desktopMenuManager/menus/menus.dart';

/// Fields that can be used in the desktop UI.
class _DesktopThemeProperties {
  /// Whether to render GUI on the desktop or not, if false, only the WM windows will be rendered.
  static bool renderGUI = true;

  /// The wallpaper of the desktop background.
  static String wallpaperAssetDir = "resources/images/desktop/backgrounds/wallpaper4.jpg";
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

  @override
  void initState() {
    super.initState();

    _wmController = WmController(() {
      setState(() {});
    });
  }

  /// The [BuildContext] for the desktop UI, the use of
  /// this field is meant ONLY for the desktop menu system.
  static BuildContext? publicContext;

  static DesktopMenu? _dm;
  static Alignment _dmPosToAlign = Alignment.topLeft;
  static void setDesktopMenuWidget(DesktopMenu? dm) {
    _dm = dm;
    if (dm == null) return;
    switch (dm.getPos()) {
      case DesktopMenuPosition.left:
        _dmPosToAlign = Alignment.topLeft;
        break;
      case DesktopMenuPosition.center:
        _dmPosToAlign = Alignment.topCenter;
        break;
      case DesktopMenuPosition.right:
        _dmPosToAlign = Alignment.topRight;
        break;
    }
  }

  bool dockIsShown = true;

  @override
  Widget build(BuildContext context) {
    publicContext = context;

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
    Widget dock() {
      Widget base(List<Widget> children) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: children,
          ),
        );
      }

      if (dockIsShown) {
        return base([
          Positioned(
            child: MouseRegion(
              onExit: (event) => setState(() {
                dockIsShown = false;
              }),
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
                        _DesktopWidgets._dockItem(null, () {
                          Applications.sys$runProcess(WidgetTesting());
                        }),
                        _DesktopWidgets._dockItem("resources/images/_icontheme/Default/apps/system-settings.svg", () {
                          Applications.sys$runProcess(Settings());
                        }),
                        _DesktopWidgets._dockItem(null, () {
                          Applications.sys$runProcess(Test());
                        }),
                        _DesktopWidgets._dockItem("resources/images/_icontheme/Default/apps/development-appmaker.svg", () {
                          Applications.sys$runProcess(AppMaker());
                        }),
                        _DesktopWidgets._dockItem("resources/images/_icontheme/Default/apps/utilities-terminal.svg", () {
                          Applications.sys$runProcess(Terminal());
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]);
      } else {
        return base([
          Positioned(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 3,
              child: MouseRegion(
                onEnter: (event) => setState(() => dockIsShown = true),
              ),
            ),
          ),
        ]);
      }
    }

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
                  _DesktopWidgets._topBarItem(null, _DesktopWidgets._topBarItemIcon(context, Icons.apps), true, () {
                    setState(() => DesktopMenuController.showMenu(LauncherMenu()));
                  }),
                  // TaskView button.
                  _DesktopWidgets._topBarItem(null, _DesktopWidgets._topBarItemIcon(context, Icons.menu_open), true, () {}),
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
                  _DesktopWidgets._topBarItem(
                      null,
                      Row(children: [
                        _DesktopWidgets._topBarItemIcon(context, Icons.mic),
                        const SizedBox(width: 3),
                        _DesktopWidgets._topBarItemIcon(context, Icons.camera)
                      ]),
                      true,
                      () {}),
                  // QuickSettings button.
                  _DesktopWidgets._topBarItem(
                      null,
                      Row(children: [
                        _DesktopWidgets._topBarItemIcon(context, Icons.wifi),
                        const SizedBox(width: 3),
                        _DesktopWidgets._topBarItemIcon(context, Icons.volume_mute),
                        const SizedBox(width: 3),
                        _DesktopWidgets._topBarItemIcon(context, Icons.battery_full)
                      ]),
                      true,
                      () {}),
                  // Notifications and Time&Date button.
                  _DesktopWidgets._topBarItem(
                      null,
                      Row(children: [
                        const DeuiText(isTitle: false, text: "19:00"),
                        const SizedBox(width: 3),
                        _DesktopWidgets._topBarItemIcon(context, Icons.notifications)
                      ]),
                      true,
                      () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    List<Widget> getDesktopLayersUI() {
      List<Widget> widgets = [
        // Context menu area.
        DeuiContextMenuArea(
          contextMenu: DeuiContextMenu(
            items: [
              DeuiContextMenuItem(
                text: "Item",
                onPress: () {},
              ),
            ],
          ),
        ),

        // The layer for the desktop windows.
        windowLayer,

        // The dock shown in the bottom of the desktop UI.
        dock(),

        // This is the TopBar, it's shown on the top of the desktop UI.
        topBar,
      ];

      // The desktop-menu clicking area to close an active menu.
      if (_dm != null) {
        widgets.add(
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => setState(() => _dm = null),
            ),
          ),
        );
      }

      // The desktop-menu layer of the desktop.
      widgets.add(
        Positioned(
          left: 5,
          right: 5,
          top: 35,
          bottom: 5,
          child: Align(
            alignment: _dmPosToAlign,
            child: _dm == null
                ? null
                : DeuiBlurContainer(
                    width: _dm?.getSize().width,
                    height: _dm?.getSize().height,
                    gradient: true,
                    radiusSides: BorderRadiusSides(true, true, true, true),
                    child: _dm?.getContents() ?? const Placeholder(),
                  ),
          ),
        ),
      );

      return widgets;
    }

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
                children: getDesktopLayersUI(),
              ),
            ),
          );
  }
}

/// A class that contains all the desktop widgets like the TopBar buttons, Dock items, etc.
class _DesktopWidgets {
  /// The item element(s) that will be shown in the dock.
  static Widget _dockItem(String? img, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: DeuiButtonBaseGlasshover(
        height: 70,
        width: 70,
        padding: const EdgeInsets.all(10),
        borderRadius: JappeOsDesktopUI.getDefaultBorderRadius() - 5,
        backgroundColor: Colors.transparent,
        backgroundColorTransp: false,
        onPress: onPressed,
        child: img != null
            ? SvgPicture.asset(img)
            : const Placeholder(),
      ),
    );
  }

  /// The item element(s) used in the topBar widget.
  static Widget _topBarItem(String? text, Widget? customWidget, bool custom, Function()? onPressed) {
    return DeuiButtonBaseGlasshover(
      height: 26,
      onPress: onPressed,
      padding: const EdgeInsets.only(left: 5, right: 5),
      margin: const EdgeInsets.only(left: 5, right: 5, top: 2),
      backgroundColorTransp: false,
      backgroundColor: Colors.transparent,
      borderRadius: 15,
      child: custom ? customWidget : DeuiText(isTitle: false, text: text ?? "null"),
    );
  }

  /// The icons used in the [_topBarItem] element.
  static Widget _topBarItemIcon(BuildContext context, IconData iconData) {
    return Icon(
      iconData,
      size: 17,
      color: SHUI_THEME_PROPERTIES(context).normalTextColor,
    );
  }
}
