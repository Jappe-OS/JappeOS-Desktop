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
import 'package:jappeos_desktop/system/appSystem/iApplication.dart';
import 'package:jappeos_desktop/system/desktop_cfg.dart';
import 'package:jappeos_desktop/system/widgets/basic/buttons/normal_buttons.dart';
import 'package:jappeos_desktop/system/widgets/basic/switch/normal_switches.dart';
import 'package:jappeos_desktop/system/widgets/basic/text/text.dart';
import 'package:jappeos_desktop/system/widgets/basic/textField/normal_text_fields.dart';
import 'package:provider/provider.dart';
import 'package:shade_ui/widgets/widgets.dart';

class WidgetTesting extends Application implements IApplication {
  WidgetTesting() : super("WidgetTesting", "widget-testing", null);

  @override
  void app$launch() {
    DesktopState.getWmController()?.wm$spawnGuiWindow("WidgetTesting", body(), null, false, const Size(500, 400), const Size(500, 400));
  }

  @override
  Widget body() {
    return _Content();
  }

  @override
  Widget? cwd() {
    return null;
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DesktopCfg$ThemeManager>(context);

    return Column(
      children: [
        Wrap(
          spacing: 10,
          direction: Axis.horizontal,
          children: [
            UINormalButtonsPrimaryTextButton(text: "Primary Button", onPress: () {}),
            UINormalButtonsSecondaryTextButton(text: "Secondary Button", onPress: () {}),
            const UITextNormalText(text: "This is a text widget."),
            const SizedBox(
              width: 200,
              child: UINormalTextFieldsTextField(
                hintText: "Type Here...",
              ),
            ),
            UINormalSwitchesNormalSwitch(
              value: themeProvider.isDarkMode(),
              onChanged: (value) {
                themeProvider.setDarkMode(value);
              },
            ),
            const UITextNormalText(text: "> New widgets >>>>"),
            ShadeButton(text: 'Primary ShadeButton', isPrimary: true, onPress: () {},),
            ShadeButton(text: 'Secondary ShadeButton', isPrimary: false, onPress: () {},),
            const ShadeTextfield(hintText: 'Type something...',),
            const ShadeText(text: 'text'),
            const ShadeIcon(icon: Icons.logo_dev),
            ShadeSwitch(
              value: themeProvider.isDarkMode(),
              onChanged: (value) {
                themeProvider.setDarkMode(value);
              },
            ),
          ],
        )
      ],
    );
  }
}
