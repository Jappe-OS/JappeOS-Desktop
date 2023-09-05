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
import 'package:jappeos_desktop/base/base.dart';
import 'package:jappeos_desktop/window_manager/window_manager.dart';

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

class TabsConfig {
  static List<String> tabs = [];
  static int selectedTabIndex = 0;
}

class ShadeTabSystemTab extends StatefulWidget {
  final String text;

  const ShadeTabSystemTab({Key? key, required this.text}) : super(key: key);

  @override
  State<ShadeTabSystemTab> createState() => _ShadeTabSystemTabState();
}

class _ShadeTabSystemTabState extends State<ShadeTabSystemTab> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 180,
      child: MouseRegion(
        onEnter: (p0) => setState(() => isHovered = true),
        onExit: (p0) => setState(() => isHovered = false),
        child: Row(
          children: [
            Expanded(
              child: Text(widget.text),
            ),
            if (isHovered) IconButton(
              onPressed: () {},
              icon: const Icon(Icons.close),
              iconSize: 18,
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}

class ShadeTabSystem extends StatefulWidget {
  const ShadeTabSystem({Key? key}) : super(key: key);

  @override
  State<ShadeTabSystem> createState() => _ShadeTabSystemState();
}

class _ShadeTabSystemState extends State<ShadeTabSystem> with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = TabController(
      length: TabsConfig.tabs.length,
      vsync: this,
      initialIndex: TabsConfig.selectedTabIndex,
    );
    super.initState();
  }

  void updateTabs() {
    try {
      controller = TabController(
        length: TabsConfig.tabs.length,
        vsync: this,
        initialIndex: TabsConfig.selectedTabIndex,
      );
      setState(() {});
    } catch (on) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TabBar(
              isScrollable: true,
              controller: controller,
              labelColor: Theme.of(context).textTheme.labelMedium!.color,
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
              unselectedLabelColor: Theme.of(context).hintColor,
              indicatorSize: TabBarIndicatorSize.tab,
              splashBorderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              indicator: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(width: 1, color: Theme.of(context).colorScheme.outline)
                // TODO : Non-uniform border sides with radius!! Check line below!
                //border: Border(
                //  top: BorderSide(width: 1, color: Theme.of(context).colorScheme.outline),
                //  left: BorderSide(width: 1, color: Theme.of(context).colorScheme.outline),
                //  right: BorderSide(width: 1, color: Theme.of(context).colorScheme.outline),
                //),
              ),
              tabs: List.generate(
                TabsConfig.tabs.length,
                (index) => ShadeTabSystemTab(text: TabsConfig.tabs[index]),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: List.generate(
                  TabsConfig.tabs.length,
                  (index) => Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Center(
                      child: Text("${TabsConfig.tabs[index]}"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          TabsConfig.tabs.add('New tab ${TabsConfig.tabs.length}');
          // setState(() {});
          updateTabs();
        },
      ),
    );
  }
}

class ShadeTabItem {
  final String title;
  final Widget content;

  ShadeTabItem({required this.title, required this.content});
}

//class ShadeTabSystem extends StatefulWidget {
//  const ShadeTabSystem({Key? key}) : super(key: key);
//
//  @override
//  _ShadeTabSystemState createState() => _ShadeTabSystemState();
//}
//
//class _ShadeTabSystemState extends State<ShadeTabSystem> with SingleTickerProviderStateMixin {
//  late TabController _tabController;
//  int _tabCount = 3;
//
//  List<List<Widget>> _tabs = [];
//
//  @override
//  void initState() {
//    super.initState();
//    _tabController = TabController(length: _tabCount, vsync: _VsyncProvider(this));
//  }
//
//  @override
//  void dispose() {
//    _tabController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    _tabs = [
//      _tab(context, "Tab1", const Text("Content for Tab 1")),
//      _tab(context, "Tab2", const Text("Content for Tab 2")),
//      _tab(context, "Tab3", const Text("Content for Tab 3")),
//      [const Icon(Icons.add), const Placeholder()],
//    ];
//
//    _updateTabControllerLength();
//
//    return Container(
//      // Rest of the code...
//    );
//  }
//
//  List<Widget> _tab(BuildContext ctx, String text, Widget content) {
//    return [
//      Tab(
//        height: 35,
//        child: Container(
//          constraints: const BoxConstraints(minWidth: 180),
//          child: Center(
//            child: Text(
//              text,
//            ),
//          ),
//        ),
//      ),
//      Container(
//        color: Theme.of(context).colorScheme.background,
//        child: content,
//      ),
//    ];
//  }
//
//  void _addTab() {
//    setState(() {
//      _tabCount++;
//      _tabs.insert(
//        _tabs.length - 1,
//        _tab(context, "Tab$_tabCount", Text("Content for Tab $_tabCount")),
//      );
//      _updateTabControllerLength();
//      _tabController.animateTo(_tabs.length - 2);
//    });
//  }
//
//  void _updateTabControllerLength() {
//    _tabController.dispose();
//    _tabController = TabController(length: _tabs.length, vsync: _VsyncProvider(this));
//  }
//}
//
//class _VsyncProvider implements TickerProvider {
//  final _ShadeTabSystemState state;
//
//  _VsyncProvider(this.state);
//
//  @override
//  Ticker createTicker(TickerCallback onTick) => Ticker(onTick, debugLabel: 'vsync');
//}