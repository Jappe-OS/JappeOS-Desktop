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
import 'package:shade_ui/widgets/shade_menu_strip.dart';

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

// ignore: must_be_immutable
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
            TextButton(
              child: const Text('TextButton'),
              onPressed: () {},
            ),
            OutlinedButton(
              child: const Text('OutlinedButton'),
              onPressed: () {},
            ),
            FilledButton(
              child: const Text('FilledButton'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: const Text('ElevatedButton'),
              onPressed: () {},
            ),
            SegmentedButton<int>(
              segments: const <ButtonSegment<int>>[
                ButtonSegment<int>(value: 0, label: Text('Item 1')),
                ButtonSegment<int>(value: 1, label: Text('Item 2')),
                ButtonSegment<int>(value: 2, label: Text('Item 3')),
              ],
              selected: const <int>{0},
              onSelectionChanged: (Set<int> newSelection) {},
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Type something...',
              )
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'This is a label!',
              )
            ),
            const Text('text'),
            const Icon(Icons.logo_dev),
            Switch(
              value: true,
              onChanged: (value) {
              },
            ),
            SizedBox(
              width: 300,
              child: Slider(value: _sliderVal, onChanged: (d) => _sliderVal = d),
            ),
          ],
        )
      ],
    );
  }
}
