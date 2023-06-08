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
import 'package:jappeos_desktop/desktop/desktop.dart';
import 'package:jappeos_desktop/system/appSystem/application.dart';
import 'package:jappeos_desktop/windowManager/windowTypes/normal_window.dart';
import 'package:jappeos_desktop/windowManager/windowTypes/wm_window_general.dart';
import 'package:shade_theming/shade_theming.dart';
import 'package:shade_ui/widgets/widgets.dart';

class Terminal extends Application {
  Terminal() : super("Terminal", "terminal", null);

  @override
  void app$launch() {
    DesktopState.getWmController()
        ?.wm$spawnGuiWindow(NormalWindow("Terminal", null, WMWindowSize(const Size(400, 300), const Size(400, 300)), true, _Content()));
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: ShadeTabSystem(),
    );
  }
}

class ShadeTabSystem extends StatefulWidget {
  const ShadeTabSystem({Key? key}) : super(key: key);

  @override
  _ShadeTabSystemState createState() => _ShadeTabSystemState();
}

class _ShadeTabSystemState extends State<ShadeTabSystem> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<List<Widget>> _tabs = [];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabs = [
      _tab("Tab1", const Text("Content for Tab 1")),
      _tab("Tab2", const Text("Content for Tab 2")),
      _tab("Tab3", const Text("Content for Tab 3")),
    ];

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
      ),
      child: Column(
        children: [
          SizedBox(width: double.infinity, child: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: _tabController,
            indicator:
                BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)), color: SHUI_THEME_PROPERTIES(context).backgroundColor1),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: _tabs.map((tab) => tab[0]).toList(),
          ),),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabs.map((tab) => tab[1]).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _tab(String text, Widget content) {
    return [
      Tab(
        height: 35,
        child: Container(
          constraints: const BoxConstraints(minWidth: 180),
          child: Center(
            child: ShadeText(
              text: text,
            ),
          ),
        ),
      ),
      Container(color: SHUI_THEME_PROPERTIES(context).backgroundColor1, child: content,),
    ];
  }
}