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
import 'package:provider/provider.dart';
import 'package:shade_theming/main.dart';
import 'package:shade_ui/widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  final String title;
  final List<SettingsPageItem> content;

  const SettingsPage({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShadeText(
            text: widget.title,
            style: ShadeTextStyle.title,
          ),
          ...widget.content,
        ],
      ),
    );
  }
}

class SettingsPageItem extends StatefulWidget {
  final String title;
  final List<Widget> content;

  const SettingsPageItem({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  _SettingsPageItemState createState() => _SettingsPageItemState();
}

class _SettingsPageItemState extends State<SettingsPageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.watch<ShadeThemeProvider>().getCurrentThemeProperties().backgroundColor2,
        borderRadius: BorderRadius.circular(10),
        //border: Border.all(color: context.watch<ShadeThemeProvider>().getCurrentThemeProperties().borderColor),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 20,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShadeText(
            text: widget.title,
            style: ShadeTextStyle.title1,
          ),
          ...widget.content,
        ],
      ),
    );
  }
}

class SettingsPageSetting extends StatefulWidget {
  final String name;
  final List<Widget> controls;

  const SettingsPageSetting({Key? key, required this.name, required this.controls}) : super(key: key);

  @override
  _SettingsPageSettingState createState() => _SettingsPageSettingState();
}

class _SettingsPageSettingState extends State<SettingsPageSetting> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Stack(
        children: [
          Positioned(
            top: 4,
            left: 0,
            child: ShadeText(text: widget.name, style: ShadeTextStyle.big,),
          ),
          Positioned(
            right: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: widget.controls,
            ),
          ),
        ],
      ),
    );
  }
}
