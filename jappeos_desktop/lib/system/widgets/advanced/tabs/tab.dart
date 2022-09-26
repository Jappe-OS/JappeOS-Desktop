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

/// A tab widget that can be used in the tabSystem.
class UITabsTab extends StatefulWidget {
  final String text;

  const UITabsTab({Key? key, required this.text}) : super(key: key);

  @override
  _Tab createState() => _Tab();
}

class _Tab extends State<UITabsTab> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(widget.text.toUpperCase()),
      ),
    );
  }
}
