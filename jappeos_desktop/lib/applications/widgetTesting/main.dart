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

import 'package:jappeos_desktop/desktop.dart';
import 'package:jappeos_desktop/system/appSystem/application.dart';
import 'package:jappeos_desktop/system/appSystem/iApplication.dart';
import 'package:jappeos_desktop/system/desktopCfg.dart';
import 'package:jappeos_desktop/system/widgets/basic/buttons/normalButtons.dart';
import 'package:jappeos_desktop/system/widgets/basic/switch/normalSwitches.dart';
import 'package:jappeos_desktop/system/widgets/basic/text/text.dart';
import 'package:jappeos_desktop/system/widgets/basic/textField/normalTextFields.dart';

class WidgetTesting extends Application implements IApplication {
  WidgetTesting() : super("WidgetTesting", "widget-testing", null);

  void app$launch() {
    DesktopState.getWmController()?.wm$spawn_gui_window("WidgetTesting", body(), null, false);
  }

  Widget body() {
    return _Content();
  }

  Widget? cwd() {
    return null;
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final themeProvider = DesktopCfg.DESKTOPCFG_INSTANCE.getThemeProvider(context);

    return new Container(
      child: Column(
        children: [
          Wrap(
            spacing: 10,
            direction: Axis.horizontal,
            children: [
              UI_NormalButtons_PrimaryTextButton(
                text: "Primary Button",
                onPress: () {}
              ),
              UI_NormalButtons_SecondaryTextButton(
                text: "Secondary Button",
                onPress: () {}
              ),
              UI_Text_NormalText(
                text: "This is a text widget."
              ),
              Container(
                width: 200,
                child: UI_NormalTextFields_TextField(
                  hintText: "Type Here...",
                ),
              ),
              UI_NormalSwitches_NormalSwitch(
                value: DesktopCfg.DESKTOPCFG_INSTANCE.isDarkMode(context),
                onChanged: (value) {
                  DesktopCfg.DESKTOPCFG_INSTANCE.setDarkMode(context, value);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
