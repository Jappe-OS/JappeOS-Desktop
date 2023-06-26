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

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:jappeos_desktop/application.dart';
import 'package:shade_theming/shade_theming.dart';
import 'package:shade_ui/utils.dart';
import 'package:shade_ui/widgets/widgets.dart';

import '../../base/base.dart';
import '../../window_manager/window_manager.dart';

class Calculator extends Application {
  Calculator() : super("Calculator", "calculator", null);

  @override
  void app$launch() {
    DesktopState.getWmController()
        ?.wm$spawnGuiWindow(NormalWindow("Calculator", null, WMWindowSize(const Size(300, 500), const Size(300, 500)), true, _Content()));
  }
}

class _Content extends StatelessWidget {
  String _calculation = "0";

  @override
  Widget build(BuildContext context) {
    Widget calculatorButton(String text, bool isPrimary, double size, void Function() onPress) {
      return Padding(
        padding: const EdgeInsets.all(SHUI_OPTIMAL_UI_PADDING),
        child: Container(
          width: size,
          height: size,
          color: Colors.blue,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(SHUI_OPTIMAL_UI_PADDING),
        child: Column(
          children: [
            const SizedBox(
                height: 100,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ShadeText(
                    text: "Infinity",
                    style: ShadeTextStyle.title1,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(SHUI_OPTIMAL_UI_PADDING),
              child: Container(
                height: 1,
                color: SHUI_THEME_PROPERTIES(context).borderColor,
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final buttonSize = (constraints.maxWidth - 20) / 3; // Calculate button size dynamically
                  final crossAxisCount = (constraints.maxWidth / buttonSize).floor();

                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1,
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: buttonSize,
                        height: buttonSize,
                        child: ElevatedButton(
                          onPressed: () {
                            // Button pressed logic
                          },
                          child: Text('Button ${index + 1}'),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
