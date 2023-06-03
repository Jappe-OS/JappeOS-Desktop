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
import 'package:jappeos_desktop/desktop/desktop.dart';
import 'package:jappeos_desktop/system/appSystem/application.dart';
import 'package:jappeos_desktop/windowManager/windowTypes/normal_window.dart';
import 'package:jappeos_desktop/windowManager/windowTypes/wm_window_general.dart';
import 'package:provider/provider.dart';
import 'package:shade_theming/main.dart';
import 'package:shade_ui/widgets/widgets.dart';

import 'settings_page_widgets.dart';

class Settings extends Application {
  Settings() : super("Settings", "settings", null);

  @override
  void app$launch() {
    DesktopState.getWmController()
        ?.wm$spawnGuiWindow(NormalWindow("Settings", null, WMWindowSize(const Size(400, 300), const Size(400, 300)), true, _Content()));
  }

  static double sidebarWidth = 300;

  // OLD
  /*Widget body() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(
              top: 0,
              left: 332,
            ),
            color: Colors.transparent,
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [
                JSettingsTileTitle(
                  jtitle: 'Connect to wifi',
                  jenditem: Container(),
                ),
                JSettingsTile(
                  // setting tile
                  //jheight: 100,
                  jitems: Column(
                    // setting tile content
                    children: [
                      Container(
                        height: 20,
                        child: Text(
                          'nothing here yet',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 330, top: 10, bottom: 10),
              width: 1,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              //margin: EdgeInsets.only(top: 55,),
              padding: EdgeInsets.only(
                top: 10,
              ),
              width: 330, // 300 + 10 + 10 + 10
              height: double.infinity,
              color: Colors.transparent,
              child: ListView(children: [
                SettingsSidebarButton(
                  jicon: Icons.wifi,
                  jtext: 'Wifi',
                  jstartopacity: 1,
                  jhighlight: DesktopCfg.get
                          .getJappeosThemeColor(JappeOsColor.DEFAULT) ??
                      Colors.white,
                ),
                SettingsSidebarButton(
                  jicon: Icons.bluetooth,
                  jtext: 'Bluetooth',
                  jstartopacity: 0,
                  jhighlight:
                      DesktopCfg.get.dsktp_TEXT_COLOR_LIGHT,
                ),
                SettingsSidebarButton(
                  jicon: Icons.edit,
                  jtext: 'Appearance',
                  jstartopacity: 0,
                  jhighlight:
                      DesktopCfg.get.dsktp_TEXT_COLOR_LIGHT,
                ),
                SettingsSidebarButton(
                  jicon: Icons.notifications,
                  jtext: 'Notifications',
                  jstartopacity: 0,
                  jhighlight:
                      DesktopCfg.get.dsktp_TEXT_COLOR_LIGHT,
                ),
                SettingsSidebarButton(
                  jicon: Icons.system_update,
                  jtext: 'Updates',
                  jstartopacity: 0,
                  jhighlight:
                      DesktopCfg.get.dsktp_TEXT_COLOR_LIGHT,
                ),
                SettingsSidebarButton(
                  jicon: Icons.language,
                  jtext: 'Regions & Language',
                  jstartopacity: 0,
                  jhighlight:
                      DesktopCfg.get.dsktp_TEXT_COLOR_LIGHT,
                ),
                SettingsSidebarButton(
                  jicon: Icons.account_circle,
                  jtext: 'Accounts',
                  jstartopacity: 0,
                  jhighlight:
                      DesktopCfg.get.dsktp_TEXT_COLOR_LIGHT,
                ),
                SettingsSidebarButton(
                  jicon: Icons.security,
                  jtext: 'Security',
                  jstartopacity: 0,
                  jhighlight:
                      DesktopCfg.get.dsktp_TEXT_COLOR_LIGHT,
                ),
                SettingsSidebarButton(
                  jicon: Icons.surround_sound,
                  jtext: 'Sound',
                  jstartopacity: 0,
                  jhighlight:
                      DesktopCfg.get.dsktp_TEXT_COLOR_LIGHT,
                ),
                SettingsSidebarButton(
                  jicon: Icons.power_settings_new,
                  jtext: 'Power',
                  jstartopacity: 0,
                  jhighlight:
                      DesktopCfg.get.dsktp_TEXT_COLOR_LIGHT,
                ),
                SettingsSidebarButton(
                  jicon: Icons.info,
                  jtext: 'About',
                  jstartopacity: 0,
                  jhighlight:
                      DesktopCfg.get.dsktp_TEXT_COLOR_LIGHT,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }*/

}

class _Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  int _selectedPage = 0;
  Widget _page = const Placeholder();

  @override
  Widget build(BuildContext context) {
    final BorderRadius br = BorderRadius.circular(8);

    Widget sidebarItem(int index, String text, IconData icon, List<SettingsPageItem> items) {
      return Container(
        height: 35,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: br,
          color: _selectedPage == index ? context.watch<ShadeThemeProvider>().getCurrentThemeProperties().accentColor.withOpacity(0.6) : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            mouseCursor: SystemMouseCursors.alias,
            borderRadius: br,
            hoverColor: context.watch<ShadeThemeProvider>().getCurrentThemeProperties().darkerTextColor.withOpacity(0.2),
            onTap: () {
              setState(() {
                _selectedPage = index;
                _page = SettingsPage(title: text, content: items);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: context.watch<ShadeThemeProvider>().getCurrentThemeProperties().normalTextColor.withOpacity(0.8),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        color: context.watch<ShadeThemeProvider>().getCurrentThemeProperties().normalTextColor.withOpacity(0.8),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            width: Settings.sidebarWidth,
            child: ListView(
              padding: const EdgeInsets.all(5),
              children: [
                sidebarItem(0, "Wi-Fi", Icons.wifi, [
                  SettingsPageItem(title: "Connect to the Internet", content: [
                    SettingsPageSetting(name: 'Select Wi-Fi network', controls: [ShadeButton(text: "Hello!", onPress: () {},)],),
                  ],),
                ]),
                sidebarItem(1, "Bluetooth", Icons.bluetooth, []),
                sidebarItem(2, "Appearance", Icons.edit, [
                  SettingsPageItem(title: "Desktop Wallpaper", content: [
                    SettingsPageSetting(name: 'Select a wallpaper', controls: [ShadeButton(icon: Icons.folder, onPress: () {},)],),
                  ],),
                  SettingsPageItem(title: "Theme", content: [
                    SettingsPageSetting(name: 'Enable dark theme', controls: [ShadeSwitch(
                      value: context.watch<ShadeThemeProvider>().getTheme() != 0,
                      onChanged: (value) {
                        setState(() {
                          Provider.of<ShadeThemeProvider>(context, listen: false).setTheme(value == true ? 1 : 0);
                        });
                      },
                    )],),
                    SettingsPageSetting(name: 'Accent color', controls: [
                      ShadeButton(icon: Icons.colorize, onPress: () {},)
                    ],),
                  ],),
                  SettingsPageItem(title: "Performance", content: [
                    SettingsPageSetting(name: 'Disable blur', controls: [ShadeSwitch(value: false, onChanged: (p0) {
                      
                    },)],),
                  ],),
                ]),
                sidebarItem(3, "Notifications", Icons.notifications, [
                  SettingsPageItem(title: "Do not Disturb", content: [
                    SettingsPageSetting(name: 'Enable Do-not-Disturb mode', controls: [ShadeSwitch(value: false, onChanged: (p0) {
                      
                    },)],),
                    SettingsPageSetting(name: 'Auto-disable Do-not-Disturb mode after', controls: [ShadeSwitch(value: false, onChanged: (p0) {
                      
                    },), ShadeButton(text: "Coming Soon", onPress: () {},)],),
                  ],),
                ]),
                sidebarItem(4, "Updates", Icons.update, []),
                sidebarItem(5, "Region & Language", Icons.language, []),
                sidebarItem(6, "Accounts", Icons.account_circle, []),
                sidebarItem(7, "Security", Icons.security, []),
                sidebarItem(8, "Sound", Icons.speaker, []),
                sidebarItem(9, "Power", Icons.power, []),
                sidebarItem(10, "About", Icons.info, []),
              ],
            ),
          ),
          Positioned(
              left: Settings.sidebarWidth,
              width: 1,
              top: 5,
              bottom: 0,
              child: Container(
                width: 1,
                color: context.watch<ShadeThemeProvider>().getCurrentThemeProperties().borderColor,
              )),
          Positioned(
            top: 0,
            left: Settings.sidebarWidth + 1,
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(5)),
                color: context.watch<ShadeThemeProvider>().getCurrentThemeProperties().backgroundColor1,
              ),
              child: ListView(children: [_page],),
            ),
          ),
        ],
      ),
    );
  }
}
