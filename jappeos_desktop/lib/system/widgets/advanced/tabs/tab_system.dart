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
import 'package:jappeos_desktop/system/desktop_cfg.dart';
import 'package:jappeos_desktop/system/widgets/basic/text/text.dart';
import 'package:provider/provider.dart';

/// A complete basic widget with tabs and tab content.
class UITabsNormalTabSystem extends StatefulWidget {
  final List<Widget> tabs;
  final List<Widget> pages;

  const UITabsNormalTabSystem({Key? key, required this.tabs, required this.pages}) : super(key: key);

  @override
  _NormalTabSystem createState() => _NormalTabSystem();
}

class _NormalTabSystem extends State<UITabsNormalTabSystem> {
  final double _barHeight = 45;
  final double _pad = 5;

  @override
  Widget build(BuildContext context) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    return Container(
      color: themeColorGetters.getBackgroundColor(context, DesktopCfg$BackgroundColorType.normal),
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
                    labelColor: themeColorGetters.getTextColor(context, DesktopCfg$TextColorType.title),
                    unselectedLabelColor: themeColorGetters.getTextColor(context, DesktopCfg$TextColorType.normal),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: themeColorGetters.getBackgroundColor(context, DesktopCfg$BackgroundColorType.brighter),),
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
class UITabsAdvancedTabSystem extends StatefulWidget {
  final Widget tab;

  const UITabsAdvancedTabSystem({Key? key, required this.tab}) : super(key: key);

  @override
  _AdvancedTabSystem createState() => _AdvancedTabSystem();
}

class _AdvancedTabSystem extends State<UITabsAdvancedTabSystem> {
  final double _barHeight = 45;
  final double _pad = 5;

  final int _length = 3;

  @override
  Widget build(BuildContext context) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    return Container(
      color: themeColorGetters.getBackgroundColor(context, DesktopCfg$BackgroundColorType.normal),
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
                labelColor: themeColorGetters.getTextColor(context, DesktopCfg$TextColorType.title),
                unselectedLabelColor: themeColorGetters.getTextColor(context, DesktopCfg$TextColorType.normal),
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: themeColorGetters.getBackgroundColor(context, DesktopCfg$BackgroundColorType.brighter),),
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
class _AdvancedCloseButton extends StatefulWidget {
  final void Function()? onPress;

  const _AdvancedCloseButton({Key? key, required this.onPress}) : super(key: key);

  @override
  _AdvancedCloseButtonState createState() => _AdvancedCloseButtonState();
}

class _AdvancedCloseButtonState extends State<_AdvancedCloseButton> {
  @override
  Widget build(BuildContext context) {
    final themeColorGetters = Provider.of<DesktopCfg$ThemeColorGetters>(context);

    return SizedBox(
      width: 30,
      height: 30,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          enabledMouseCursor: SystemMouseCursors.alias,
          disabledMouseCursor: SystemMouseCursors.alias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: widget.onPress,
        child: Icon(Icons.close,
            size: 17, color: themeColorGetters.getTextColor(context, DesktopCfg$TextColorType.title)),
      ),
    );
  }
}

// Some private widgets that don't need to use a BuildContext.
class _PrivateWidgets {
  static Widget advancedTab(String text) {
    return SizedBox(
      width: 250,
      child: Tab(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const FlutterLogo(size: 20),
                  Container(width: 8),
                  UITextNormalText(text: text),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 8),
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
