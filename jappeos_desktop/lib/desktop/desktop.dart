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

import 'package:jappeos_desktop/applications/settings/main.dart';
import 'package:jappeos_desktop/applications/terminal/main.dart';
import 'package:jappeos_desktop/applications/widgetTesting/main.dart';
import 'package:jappeos_desktop/desktop/desktopMenuManager/d_menu_controller.dart';
import 'package:jappeos_desktop/desktop/desktopMenuManager/d_menu_manager.dart';
import 'package:jappeos_desktop/system/appSystem/applications.dart';
import 'package:jappeos_desktop/system/desktop_cfg.dart';
import 'package:jappeos_desktop/system/widgets/basic/textField/normal_text_fields.dart';
import 'package:provider/provider.dart';

import '../windowManager/wmcontroller.dart';
import '../windowManager/wmmanager.dart';

/// Fields that can be used in the desktop UI.
class _DesktopThemeProperties {
  /// A border radius mainly used for background UI elements.
  static const double borderRadius = 10;
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
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            // The desktop background image.
            image: AssetImage("lib/images/desktop/backgrounds/wallpaper2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // The window layer of the desktop UI.
            Positioned(
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
            ),

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
            _DesktopElements.dock(context),

            // This is the TopBar, it's shown on the top of the desktop UI.
            _DesktopElements.topBar(context),
          ],
        ),
      ),
    );
  }
}

/// A class that contains all the desktop elements like the TopBar, Dock, etc.
class _DesktopElements {
  // [-- PUBLIC WIDGETS --]

  /// This is the dock, it is shown in the bottom of the screen.
  static Widget dock(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[_DesktopWidgets._basicShadow()],
          borderRadius: const BorderRadius.all(Radius.circular(_DesktopThemeProperties.borderRadius)),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: IntrinsicWidth(
          child: _DesktopWidgets._blurContainer(
              context,
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                // The items shown in the dock.
                children: [
                  _dockItem(null, null, false, () {
                    Applications.sys$runProcess(Settings());
                  }),
                  _dockItem(null, null, false, () {
                    Applications.sys$runProcess(WidgetTesting());
                  }),
                  _dockItem(null, null, false, () {
                    Applications.sys$runProcess(Terminal());
                  }),
                  _dockItem(null, null, false, () {}),
                ],
              ),
              true),
        ),
      ),
    );
  }

  /// This is the topBar, it is shown in the top of the screen. It can be used to launch apps, or using the quickSettings menu.
  static Widget topBar(BuildContext context) {
    double sidePadding = 5;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 30,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[_DesktopWidgets._basicShadow()],
        ),
        child: _DesktopWidgets._blurContainer(
            context,
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: sidePadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    // The items on the TopBar on the left side.
                    children: [
                      // Launcher button.
                      _topBarItem(
                        context,
                        null,
                        () {
                          //_desktopMenuController?.openDesktopOverlayMenu(DesktopMenu$Menus.launcher);
                        },
                        true,
                        _topBarItemIcon(
                          context,
                          Icons.apps,
                        ),
                      ),
                      const SizedBox(width: 5),
                      // TaskView button.
                      _topBarItem(
                        context,
                        null,
                        () {},
                        true,
                        _topBarItemIcon(
                          context,
                          Icons.menu_open,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: sidePadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    // The items on the TopBar on the right side.
                    children: [
                      // System tray buttons.
                      _topBarItem(
                          context,
                          null,
                          () {},
                          true,
                          Row(
                            children: [
                              _topBarItemIcon(
                                context,
                                Icons.mic,
                              ),
                              const SizedBox(width: 3),
                              _topBarItemIcon(
                                context,
                                Icons.camera,
                              ),
                            ],
                          )),
                      const SizedBox(width: 5),
                      // QuickSettings button.
                      _topBarItem(
                          context,
                          null,
                          () {},
                          true,
                          Row(
                            children: [
                              _topBarItemIcon(
                                context,
                                Icons.wifi,
                              ),
                              const SizedBox(width: 3),
                              _topBarItemIcon(
                                context,
                                Icons.volume_mute,
                              ),
                              const SizedBox(width: 3),
                              _topBarItemIcon(
                                context,
                                Icons.battery_full,
                              ),
                            ],
                          )),
                      const SizedBox(width: 5),
                      // Notifications and Time&Date button.
                      _topBarItem(
                        context,
                        null,
                        () {},
                        true,
                        Row(
                          children: [
                            const Text(
                              '19:00',
                              //style: TextStyle(
                              //  color: topBarItemContentColor,
                              //),
                            ),
                            const SizedBox(width: 3),
                            _topBarItemIcon(
                              context,
                              Icons.notifications,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            false),
      ),
    );
  }

  // [-- PRIVATE WIDGETS --]

  /// The item element(s) that will be shown in the dock. Uses [_dockItemBase] as the base.
  static Widget _dockItem(ImageProvider? img, IconData? icon, bool isIcon, Function() onPressed) {
    if (!isIcon) {
      return _dockItemBase(
          Image(
            image: img ?? const AssetImage("lib/images/null.png"),
          ),
          onPressed);
    } else {
      return _dockItemBase(
        Icon(
          icon,
          size: 40,
        ),
        onPressed,
      );
    }
  }

  /// This is the base for the [_dockItem].
  static Widget _dockItemBase(Widget child, Function() onPressed) {
    return Container(
      width: 70,
      height: 70,
      margin: const EdgeInsets.all(5),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          enabledMouseCursor: SystemMouseCursors.alias,
          disabledMouseCursor: SystemMouseCursors.alias,
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_DesktopThemeProperties.borderRadius),
          ),
        ),
        child: child,
      ),
    );
  }

  /// The item element used in the [topBar] widget.
  static Widget _topBarItem(BuildContext context, String? text, Function()? onPressed, bool custom, Widget? customWidget) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    if (!custom) {
      return TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size(30, 30),
            padding: const EdgeInsets.all(6),
            enabledMouseCursor: SystemMouseCursors.alias,
            disabledMouseCursor: SystemMouseCursors.alias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_DesktopThemeProperties.borderRadius),
            ),
          ),
          onPressed: onPressed,
          child: Text(text ?? "",
              style: TextStyle(
                color: themeColorGetters.getTextColor(context, DesktopCfg$TextColorType.normal),
              )));
    } else {
      return TextButton(
        style: TextButton.styleFrom(
          minimumSize: const Size(30, 30),
          padding: const EdgeInsets.all(6),
          enabledMouseCursor: SystemMouseCursors.alias,
          disabledMouseCursor: SystemMouseCursors.alias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_DesktopThemeProperties.borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: customWidget ?? Container(),
      );
    }
  }

  /// The icons used in the [_topBarItem] element.
  static Widget _topBarItemIcon(BuildContext context, IconData iconData) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    return Icon(
      iconData,
      size: 17,
      color: themeColorGetters.getTextColor(context, DesktopCfg$TextColorType.normal),
    );
  }
}

/// Multiple widgets that can be used within the desktop.
class _DesktopWidgets {
  /// A blur effect used for backgrounds.
  static Widget _blurContainer(BuildContext context, Widget child, bool radius) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    final BackdropFilter bf = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          color: themeColorGetters.getBackgroundColor(context, DesktopCfg$BackgroundColorType.normal),
        ),
        child: child,
      ),
    );

    if (radius) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(_DesktopThemeProperties.borderRadius)),
        child: bf,
      );
    } else {
      return ClipRRect(
        child: bf,
      );
    }
  }

  /// Shadow element for TopBar and the Dock.
  static BoxShadow _basicShadow() {
    return const BoxShadow(
      color: Colors.black,
      offset: Offset(0, 0),
      blurRadius: 10.0,
    );
  }
}

/// Contains the overlay menus for the desktop UI, for example, the launcher.
///
/// Menus:
/// - 0 = Launcher
/// - 1 = TaskView
/// - 2 = QuickSettings
class DesktopOverlayMenus extends StatelessWidget {
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
