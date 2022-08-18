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
import 'package:jappeos_desktop/system/desktopCfg.dart';
import 'package:jappeos_desktop/system/widgets/advanced/tabs/tab.dart';
import 'package:jappeos_desktop/system/widgets/basic/buttons/normalButtons.dart';
import 'package:jappeos_desktop/system/widgets/basic/text/text.dart';

/// A complete basic widget with tabs and tab content.
///
/// Made by Jappe. (2022)
class UI_Tabs_NormalTabSystem extends StatefulWidget {
  final List<Widget> tabs;
  final List<Widget> pages;

  UI_Tabs_NormalTabSystem({Key? key, required this.tabs, required this.pages}) : super(key: key);

  _NormalTabSystem createState() => _NormalTabSystem();
}

class _NormalTabSystem extends State<UI_Tabs_NormalTabSystem> {
  double _barHeight = 45;
  double _pad = 5;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
          ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_DARK
          : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_LIGHT,
      child: DefaultTabController(
          length: widget.tabs.length,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: _pad,
                right: 0,
                height: _barHeight,
                child: TabBar(
                    labelColor: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                        ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_DARK
                        : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_LIGHT,
                    unselectedLabelColor: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                        ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_DARK_SECONDARY
                        : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_LIGHT_SECONDARY,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                            ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_DARK_SECONDARY
                            : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_LIGHT_SECONDARY),
                    tabs: widget.tabs),
              ),
              Positioned(
                top: _barHeight + (_pad * 2),
                left: 0,
                bottom: 0,
                right: 0,
                child: TabBarView(children: widget.pages),
              )
            ],
          )),
    );
  }
}

/// A complete advanced widget with tabs and tab content.
/// This will allow opening new tabs, and closing them.
/// NOTE: You will need to use the same widget for each tab.
///
/// Made by Jappe. (2022)
class UI_Tabs_AdvancedTabSystem extends StatefulWidget {
  final Widget tab;

  UI_Tabs_AdvancedTabSystem({Key? key, required this.tab}) : super(key: key);

  _AdvancedTabSystem createState() => _AdvancedTabSystem();
}

class _AdvancedTabSystem extends State<UI_Tabs_AdvancedTabSystem> {
  double _barHeight = 45;
  double _pad = 5;

  int _length = 3;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
          ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_DARK
          : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_LIGHT,
      child: DefaultTabController(
        length: _length,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: _pad,
              right: 0,
              height: _barHeight,
              child: TabBar(
                isScrollable: true,
                labelColor: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                    ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_DARK
                    : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_LIGHT,
                unselectedLabelColor: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                    ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_DARK_SECONDARY
                    : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_TEXT_COLOR_LIGHT_SECONDARY,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                        ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_DARK_SECONDARY
                        : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_BG_COLOR_LIGHT_SECONDARY),
                tabs: [
                  _PrivateWidgets.advancedTab('Text'),
                  _PrivateWidgets.advancedTab('Text'),
                  _PrivateWidgets.advancedTab('Text'),
                  //UI_NormalButtons_PrimaryTextButton(text: 'new', onPress: () {})
                ],
              ),
            ),
            Positioned(
              top: _barHeight + (_pad * 2),
              left: 0,
              bottom: 0,
              right: 0,
              child: TabBarView(
                children: [
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A close button for the advanced tab.
///
/// Made by Jappe. (2022)
class _AdvancedCloseButton extends StatefulWidget {
  final void Function()? onPress;

  _AdvancedCloseButton({Key? key, required this.onPress}) : super(key: key);

  _AdvancedCloseButtonState createState() => _AdvancedCloseButtonState();
}

class _AdvancedCloseButtonState extends State<_AdvancedCloseButton> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 30,
      height: 30,
      child: TextButton(
        child: Icon(Icons.close,
            size: 17,
            color: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context)
                ? DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_ICON_COLOR_DARK
                : DesktopCfg.DESKTOPCFG_INSTANCE.dsktp_ICON_COLOR_LIGHT),
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            enabledMouseCursor: SystemMouseCursors.alias,
            disabledMouseCursor: SystemMouseCursors.alias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        onPressed: widget.onPress,
      ),
    );
  }
}


// Some private widgets that don't need to use a BuildContext.
class _PrivateWidgets {
  static Widget advancedTab(String text) {
    return Container(
      width: 250,
      child: Tab(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 8),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  FlutterLogo(size: 20),
                  Container(width: 8),
                  UI_Text_NormalText(text: text),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: _AdvancedCloseButton(onPress: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
