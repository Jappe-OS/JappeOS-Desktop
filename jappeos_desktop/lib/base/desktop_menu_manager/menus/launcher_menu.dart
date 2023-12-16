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

part of base;

class LauncherMenu extends DesktopMenu {
  final PageController _pageController = PageController();
  int _pageCount = 1;

  @override
  Widget getContents(BuildContext context) {
    //Color overlayColor = DesktopState.publicContext!.watch<ShadeThemeProvider>().getTheme() == 0
    //    ? const Color.fromRGBO(255, 255, 255, 0.3)
    //    : const Color.fromRGBO(0, 0, 0, 0.3);

    Widget controlButton(IconData icon, String tooltip, Function() onPress) {
      return IconButton(
        onPressed: onPress,
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        tooltip: tooltip,
        padding: const EdgeInsets.all(3),
      );
    }

    Widget verticalIndicatorCircleBar(int count, int active) {
      List<Widget> circles = [];

      for (int i = 0; i < count; i++) {
        circles.add(Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: i == active ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ));

        if (count != i) {
          circles.add(const SizedBox(
            height: 10,
          ));
        }
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: circles,
      );
    }

    return Column(
      children: [
        Container(
          margin: defaultPadding,
          child: DeuiButtonBase(
            backgroundColor: JappeOsDesktopUI.theme_customGlassFieldBgColor(context),
            borderRadius: 100,
            width: 500 - defaultPaddingNum * 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5 * 2),
                child: Text(
                  'Search Files, Apps & More',
                  style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 16),
                ),
              ),
            ),
            onPress: () => DesktopState.setDesktopMenuWidget(SearchMenu()),
          ),
        ),
        Expanded(
          child: Container(
            margin: defaultPadding,
            child: Row(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DApplicationItem(SvgPicture.asset("resources/images/_icontheme/Default/apps/utilities-terminal.svg"), "Terminal",
                                  () /*=> Terminal.new().app$launch()*/ {}),
                              DApplicationItem(SvgPicture.asset("resources/images/_icontheme/Default/apps/system-settings.svg"), "Settings",
                                  () /*=> Settings.new().app$launch()*/ {}),
                              DApplicationItem(SvgPicture.asset("resources/images/_icontheme/Default/apps/utilities-terminal.svg"), "ShadeUI Test",
                                  () => WidgetTesting.new().app$launch()),
                              DApplicationItem(SvgPicture.asset("resources/images/_icontheme/Default/apps/utilities-terminal.svg"), "Terminal", () {})
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DApplicationItem(
                                  SvgPicture.asset("resources/images/_icontheme/Default/apps/utilities-terminal.svg"), "Terminal", () {}),
                              DApplicationItem(
                                  SvgPicture.asset("resources/images/_icontheme/Default/apps/utilities-terminal.svg"), "Terminal", () {}),
                              DApplicationItem(
                                  SvgPicture.asset("resources/images/_icontheme/Default/apps/utilities-terminal.svg"), "Terminal", () {}),
                              DApplicationItem(SvgPicture.asset("resources/images/_icontheme/Default/apps/utilities-terminal.svg"), "Terminal", () {})
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DApplicationItem(
                                  SvgPicture.asset("resources/images/_icontheme/Default/apps/utilities-terminal.svg"), "Terminal", () {}),
                              DApplicationItem(
                                  SvgPicture.asset("resources/images/_icontheme/Default/apps/utilities-terminal.svg"), "Terminal", () {}),
                              DApplicationItem(
                                  SvgPicture.asset("resources/images/_icontheme/Default/apps/utilities-terminal.svg"), "Terminal", () {}),
                              DApplicationItem(SvgPicture.asset("resources/images/_icontheme/Default/apps/utilities-terminal.svg"), "Terminal", () {})
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: defaultPaddingNum,
                ),
                verticalIndicatorCircleBar(_pageCount, 0),
              ],
            ),
          ),
        ),
        Container(
          height: 50,
          color: JappeOsDesktopUI.theme_customGlassFieldBgColor(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              controlButton(Icons.power_settings_new, "Shut Down", () {}),
              controlButton(Icons.nightlight, "Sleep", () {}),
              controlButton(Icons.account_circle, "Account", () {}),
              controlButton(Icons.settings, "Settings", () {
                //Applications.sys$runProcess(Settings());
              }),
            ],
          ),
        ),
      ],
    );
  }

  @override
  DesktopMenuPosition getPos() => DesktopMenuPosition.left;

  @override
  Size? getSize() => const Size(500, 500);
}
