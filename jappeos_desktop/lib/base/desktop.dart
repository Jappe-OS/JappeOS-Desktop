//  JappeOS-Desktop, The desktop environment for JappeOS.
//  Copyright (C) 2023  Jappe02
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

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

part of jappeos_desktop.base;

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
  static WindowStackController? _wmController;
  static WindowStackController? getWmController() => _wmController;

  /// The [BuildContext] for the desktop UI, the use of
  /// this field is meant ONLY for the desktop menu system.
  static BuildContext? publicContext;

  /// Whether to render GUI on the desktop or not, if false, only the WM windows will be rendered.
  static bool renderGUI = true;

  late final DesktopMenuController _menuController;

  bool dockIsShown = true;

  @override
  void initState() {
    super.initState();

    _wmController = WindowStackController(() => setState(() {}));
    _menuController = DesktopMenuController((x) => setState(x ?? () {}));
  }

  @override
  Widget build(BuildContext context) {
    /*TODO: Remove*/ print("DESKTOP REBUILD");

    publicContext = context;

    // The window layer of the desktop UI.
    final Widget windowLayer = Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Stack(
        // <-- TODO: Remove extra stack
        children: [
          WindowStack(
            wmController: _wmController,
            insets: const EdgeInsets.only(top: DSKTP_UI_LAYER_TOPBAR_HEIGHT),
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
                if (!MOBILE_MODE) dockIsShown = false;
              }),
              child: Container(
                height: DSKTP_UI_LAYER_DOCK_HEIGHT,
                margin: const EdgeInsets.only(bottom: 10),
                child: IntrinsicWidth(
                  child: DOverlayContainer(
                    child: Row(
                      children: [
                        DApplicationItem.icon(
                            image: SvgPicture.asset("resources/images/_icontheme/Default/apps/development-appmaker.svg"), onPress: () {}),
                        DApplicationItem.icon(
                            image: SvgPicture.asset("resources/images/_icontheme/Default/apps/accessories-calculator.svg"), onPress: () {}),
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
      height: DSKTP_UI_LAYER_TOPBAR_HEIGHT,
      child: AdvancedContainer(
        background: AdvancedContainerBackground.transparentBackground,
        borderStyle: AdvancedContainerBorder.none,
        borderRadius: 0,
        blur: true,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // The items on the TopBar on the left side.
                children: [
                  DTopbarButton.icon(icon: Icons.apps, menuControllerRef: _menuController, menu: const LauncherMenu()),
                  DTopbarButton.icon(icon: Icons.search, menuControllerRef: _menuController, menu: const SearchMenu()),
                  //// TaskView button.
                  //_LocalDesktopWidgets._topBarItem(null, _LocalDesktopWidgets._topBarItemIcon(context, Icons.menu_open), true, () {}),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // The items on the TopBar on the right side.
                children: [
                  DTopbarButton.icons(icons: const [Icons.mic, Icons.camera], menuControllerRef: _menuController, menu: const PermissionsMenu()),
                  DTopbarButton.icons(icons: const [Icons.wifi, Icons.volume_mute, Icons.battery_full], menuControllerRef: _menuController, menu: const ControlCenterMenu()),
                  DTopbarButton.textAndIcon(icon: Icons.notifications, text: "19:00", menuControllerRef: _menuController, menu: const NotificationMenu()),
                ],
              ),
            ),
          ],
        ),
      ).copyWith(),
    );

    List<Widget> getDesktopLayersUI() {
      List<Widget> widgets = [
        // The layer for the desktop windows. Desktop mode only.
        if (!MOBILE_MODE) windowLayer,

        // The dock shown in the bottom of the desktop UI.
        dock(),

        // The layer for the desktop windows. Mobile mode only.
        if (MOBILE_MODE) windowLayer,

        // This is the TopBar, it's shown on the top of the desktop UI.
        topBar,
      ];

      // The desktop-menu clicking area to close an active menu.
      //if (_dm != null) {
      //  _dm?.setStateF = (p0) => setState(p0);
      //  widgets.add(
      //    Positioned(
      //      top: 0,
      //      left: 0,
      //      bottom: 0,
      //      right: 0,
      //      child: GestureDetector(
      //        onTap: () => setState(() => _dm = null),
      //      ),
      //    ),
      //  );
      //}

      // The desktop-menu layer of the desktop.
      if (_menuController.getWidget() != null) {
        widgets.add(_menuController.getWidget() as Widget);
      }

      return widgets;
    }

    // Desktop UI.
    return !renderGUI
        ? windowLayer
        : Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  // The desktop background image.
                  image: AssetImage(DSKTP_UI_LAYER_BACKGROUND_WALLPAPER_DIR),
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
