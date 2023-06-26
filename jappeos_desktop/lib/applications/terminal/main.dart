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
import 'package:flutter/scheduler.dart';
import 'package:jappeos_desktop/application.dart';
import 'package:jappeos_desktop/base/base.dart';
import 'package:jappeos_desktop/window_manager/window_manager.dart';
import 'package:provider/provider.dart';
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

//--

class ShadeTabSystem extends StatefulWidget {
  const ShadeTabSystem({Key? key}) : super(key: key);

  @override
  _ShadeTabSystemState createState() => _ShadeTabSystemState();
}

class _ShadeTabSystemState extends State<ShadeTabSystem> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabCount = 3;

  List<List<Widget>> _tabs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabCount, vsync: _VsyncProvider(this));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabs = [
      _tab(context, "Tab1", const Text("Content for Tab 1")),
      _tab(context, "Tab2", const Text("Content for Tab 2")),
      _tab(context, "Tab3", const Text("Content for Tab 3")),
      [const ShadeIcon(icon: Icons.add), const Placeholder()],
    ];

    _updateTabControllerLength();

    return Container(
      // Rest of the code...
    );
  }

  List<Widget> _tab(BuildContext ctx, String text, Widget content) {
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
      Container(
        color: Provider.of<ShadeThemeProvider>(context, listen: false).getCurrentThemeProperties().backgroundColor1,
        child: content,
      ),
    ];
  }

  void _addTab() {
    setState(() {
      _tabCount++;
      _tabs.insert(
        _tabs.length - 1,
        _tab(context, "Tab$_tabCount", Text("Content for Tab $_tabCount")),
      );
      _updateTabControllerLength();
      _tabController.animateTo(_tabs.length - 2);
    });
  }

  void _updateTabControllerLength() {
    _tabController?.dispose();
    _tabController = TabController(length: _tabs.length, vsync: _VsyncProvider(this));
  }
}

class _VsyncProvider implements TickerProvider {
  final _ShadeTabSystemState state;

  _VsyncProvider(this.state);

  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick, debugLabel: 'vsync');
}