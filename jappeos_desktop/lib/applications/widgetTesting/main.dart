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
import 'package:jappeos_desktop/application.dart';
import 'package:provider/provider.dart';
import 'package:shade_theming/main.dart';
import 'package:shade_ui/widgets/widgets.dart';

import '../../base/base.dart';
import '../../window_manager/window_manager.dart';

class WidgetTesting extends Application {
  WidgetTesting() : super("WidgetTesting", "widget-testing", null);

  @override
  void app$launch() {
    DesktopState.getWmController()
        ?.wm$spawnGuiWindow(NormalWindow("Widget Testing", null, WMWindowSize(const Size(400, 300), const Size(400, 300)), true, _Content()));
  }
}

class _Content extends StatelessWidget {
  double _sliderVal = 0.05;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 5,
          direction: Axis.horizontal,
          children: [
            ShadeMenuStrip(items: [
              ShadeMenuStripItem("File", () {}, [
                ShadeMenuStripItem("New", () {}, []),
                ShadeMenuStripItem("Open", () {}, []),
                ShadeMenuStripItem("Save", () {}, []),
                ShadeMenuStripItem("Exit", () {}, [])
              ])
            ]),
            ShadeButton(
              text: 'Primary ShadeButton',
              isPrimary: true,
              onPress: () {},
            ),
            ShadeButton(
              text: 'Secondary ShadeButton',
              isPrimary: false,
              onPress: () {},
            ),
            ShadeButtonBar([ShadeButtonBarItem(text: "Item 1"), ShadeButtonBarItem(text: "Item 2"), ShadeButtonBarItem(text: "Item 3")]),
            const ShadeTextfield(
              hintText: 'Type something...',
            ),
            const ShadeText(text: 'text'),
            const ShadeIcon(icon: Icons.logo_dev),
            ShadeSwitch(
              value: context.watch<ShadeThemeProvider>().getTheme() != 0,
              onChanged: (value) {
                Provider.of<ShadeThemeProvider>(context, listen: false).setTheme(value == true ? 1 : 0);
              },
            ),
            SizedBox(
              width: 300,
              child: ShadeSlider(value: _sliderVal, onChanged: (d) => _sliderVal = d),
            ),
          ],
        )
      ],
    );
  }
}
