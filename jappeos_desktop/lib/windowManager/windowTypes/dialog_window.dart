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
import 'package:jappeos_desktop/windowManager/windowTypes/wm_window_general.dart';
import 'package:jappeos_desktop_ui/widgets/text.dart';
import 'package:shade_ui/widgets/widgets.dart';

/// A simple dialog window with text.
class DialogWindow extends WMWindowType {
  final String title;
  final String content;
  final List<DialogWindowAction> actions;
  int primaryAction;

  bool _close = false;

  DialogWindow(this.title, this.content, this.actions, [this.primaryAction = 0]);

  @override
  List<Widget> getWindow() {
    List<Widget> actionsWidg = [];

    for (DialogWindowAction dwa in actions) {
      actionsWidg.add(ShadeButton(
        text: dwa.name,
        isPrimary: actions.indexOf(dwa) == primaryAction,
        onPress: dwa.act,
      ));
    }

    actionsWidg.add(ShadeButton(
      text: "Close",
      isPrimary: false,
      onPress: () => _close = true,
    ));

    return [
      Positioned(
        top: WMWindowDragAreaProperties.getDefaultH(),
        left: 0,
        bottom: 0,
        right: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ShadeText(text: content)),
            Row(
              children: actionsWidg,
            ),
          ],
        ),
      ),
      Positioned(
        top: 6,
        left: 10,
        child: DeuiText(isTitle: false, text: title),
      ),
    ];
  }

  @override
  bool applyBlur() {
    return true;
  }

  @override
  bool isResizable() {
    return false;
  }

  @override
  WMWindowDragAreaProperties? getDragAreaProperties() {
    WMWindowDragAreaProperties a = WMWindowDragAreaProperties()..setDefault();

    return a;
  }

  @override
  WMWindowSize getSizeProperties() {
    return WMWindowSize(const Size(400, 200), const Size(400, 200));
  }

  @override
  bool hasControlButtons() {
    return false;
  }

  @override
  bool close() {
    return _close;
  }
}

class DialogWindowAction {
  String name;
  void Function()? act;

  DialogWindowAction(this.name, this.act);
}
