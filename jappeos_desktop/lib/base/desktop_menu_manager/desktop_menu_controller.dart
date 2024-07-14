//  JappeOS-Desktop, The desktop environment for JappeOS.
//  Copyright (C) 2024  Jappe02
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

part of jappeos_desktop.base;

// TODO: animate the Positioned correctly
class DesktopMenuController {
  static const menuAnimationDuration = Duration(milliseconds: 100);

  DesktopMenuController(this.rebuildCallback);

  final Function(void Function()?) rebuildCallback;
  DesktopMenu? _currentMenu;
  Offset? _currentMenuPosition;
  Size _currentMenuChildSize = Size.zero;
  Size _currentStackWSize = Size.zero;
  bool _currentMenuIsInitialBuild = true;

  void openMenu(DesktopMenu menu, [Offset? position]) {
    _currentMenu = menu;
    _currentMenuPosition = position;
    _currentMenuIsInitialBuild = true;
    rebuildCallback(null);
  }

  void closeMenu() {
    _currentMenu = null;
    _currentMenuPosition = null;
    rebuildCallback(null);
  }

  Positioned? getWidget() {
    const pad = BPPresets.small;

    return _currentMenu != null
        ? Positioned(
            left: _currentMenuPosition!.dx,
            top: _currentMenuPosition!.dy,
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool wasInitialBuild = false;

                if (_currentMenuIsInitialBuild) {
                  wasInitialBuild = true;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _currentStackWSize = MediaQuery.of(context).size;

                    final renderBox = context.findRenderObject() as RenderBox;
                    _currentMenuChildSize = renderBox.size;

                    // Ensure the menu is correctly positioned within the stack
                    rebuildCallback(() {
                      var minX = pad;
                      var maxX = _currentStackWSize.width - _currentMenuChildSize.width - pad;

                      if (maxX < minX) {
                        maxX = minX;
                      }

                      var minY = DSKTP_UI_LAYER_TOPBAR_HEIGHT + pad;
                      var maxY = _currentStackWSize.height - _currentMenuChildSize.height - pad;

                      if (maxY < minY) {
                        maxY = minY;
                      }

                      _currentMenuPosition = Offset(
                        _currentMenuPosition!.dx - _currentMenuChildSize.width / 2,
                        _currentMenuPosition!.dy - _currentMenuChildSize.height / 2,
                      );

                      _currentMenuPosition = Offset(
                        _currentMenuPosition!.dx.clamp(minX, maxX),
                        _currentMenuPosition!.dy.clamp(minY, maxY),
                      );
                    });
                  });
                }

                _currentMenuIsInitialBuild = false;

                return TapRegion(
                  onTapOutside: (_) => closeMenu(),
                  child: AnimatedOpacity(
                    opacity: wasInitialBuild ? 0.3 : 1,
                    duration: menuAnimationDuration,
                    child: RepaintBoundary(
                      child: AnimatedScale(curve: Curves.easeIn, duration: menuAnimationDuration, scale: wasInitialBuild ? 0 : 1, child: _currentMenu as Widget),
                    ),
                  ),
                );
              },
            ),
          )
        : null;
  }
}

abstract class DesktopMenu extends StatefulWidget {
  const DesktopMenu({super.key});
}
