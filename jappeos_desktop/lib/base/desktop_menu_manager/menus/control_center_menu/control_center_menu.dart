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

// ignore_for_file: library_private_types_in_public_api

part of jappeos_desktop.base;

class ControlCenterMenu extends DesktopMenu {
  const ControlCenterMenu({Key? key}) : super(key: key);

  @override
  _ControlCenterMenuState createState() => _ControlCenterMenuState();
}

class _ControlCenterMenuState extends State<ControlCenterMenu> {
  final GlobalKey<NavigatorState> _containerNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return DOverlayContainer(
      width: 450,
      height: 2 * BPPresets.medium + 3 * BPPresets.small + 2 * BPPresets.big + 6 * 45 + 2,
      child: Navigator(
        key: _containerNavigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext _) => const _ControlCenterMainPage();
              break;
            case '/wifi':
              builder = (BuildContext _) => const ControlCenterWifiPage();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}

class _QuickActionItem extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final void Function(bool)? onSelectionChange;
  final void Function()? onAdditionalDetailsButtonPressed;

  const _QuickActionItem(
      {required this.text, required this.icon, required this.isSelected, this.onSelectionChange, this.onAdditionalDetailsButtonPressed});

  @override
  _QuickActionItemState createState() => _QuickActionItemState();
}

class _QuickActionItemState extends State<_QuickActionItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: FilledButton(
        onPressed: () => widget.onSelectionChange?.call(widget.isSelected),
        style: ButtonStyle(
          backgroundColor: widget.isSelected ? MaterialStatePropertyAll(Theme.of(context).colorScheme.primary) : null,
          shape: const MaterialStatePropertyAll(StadiumBorder()),
          padding: MaterialStatePropertyAll(
              EdgeInsets.only(left: BPPresets.medium, right: widget.onAdditionalDetailsButtonPressed != null ? 0 : BPPresets.medium)),
        ),
        child: Row(children: [
          Icon(widget.icon),
          const SizedBox(width: BPPresets.small),
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.text, style: Theme.of(context).textTheme.bodyMedium),
            Text(widget.isSelected.toString(), style: Theme.of(context).textTheme.bodySmall),
          ]),
          const Spacer(),
          if (widget.onAdditionalDetailsButtonPressed != null)
            IconButton(
                onPressed: widget.onAdditionalDetailsButtonPressed,
                icon: const Icon(Icons.arrow_forward_ios),
                padding: const EdgeInsets.symmetric(horizontal: BPPresets.medium, vertical: 10)),
        ]),
      ),
    );
  }
}

class ControlCenterPageBase extends StatelessWidget {
  final String title;
  final Widget body;

  const ControlCenterPageBase({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BPPresets.medium),
      child: Column(
        children: [
          Row(children: [
            IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back)),
            const Spacer(flex: 4),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const Spacer(flex: 5),
          ]),
          const SizedBox(height: BPPresets.small),
          //const Divider(),
          Expanded(child: body),
        ],
      ),
    );
  }
}

class _ControlCenterMainPage extends StatefulWidget {
  const _ControlCenterMainPage();

  @override
  _ControlCenterMainPageState createState() => _ControlCenterMainPageState();
}

class _ControlCenterMainPageState extends State<_ControlCenterMainPage> {
  Widget cont(Widget child) {
    return AdvancedContainer(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: BPPresets.small),
      borderRadius: 100,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BPPresets.medium),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              Expanded(
                  child: _QuickActionItem(
                      text: "Wi-Fi",
                      icon: Icons.wifi_rounded,
                      isSelected: true,
                      onSelectionChange: (p0) {},
                      onAdditionalDetailsButtonPressed: () => Navigator.of(context).pushNamed("/wifi"))),
              const SizedBox(width: BPPresets.small),
              Expanded(child: _QuickActionItem(text: "Bluetooth", icon: Icons.bluetooth_rounded, isSelected: false, onSelectionChange: (p0) {})),
            ]),
            const SizedBox(height: BPPresets.small),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Expanded(child: _QuickActionItem(text: "Airplane Mode", icon: Icons.airplanemode_off, isSelected: false, onSelectionChange: (p0) {})),
              const SizedBox(width: BPPresets.small),
              Expanded(child: _QuickActionItem(text: "Do not Disturb", icon: Icons.do_not_disturb_on, isSelected: true, onSelectionChange: (p0) {})),
            ]),
            const SizedBox(height: BPPresets.small),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Expanded(child: _QuickActionItem(text: "Dark Theme", icon: Icons.dark_mode_rounded, isSelected: true, onSelectionChange: (p0) {})),
              const SizedBox(width: BPPresets.small),
              Expanded(child: _QuickActionItem(text: "EN_US", icon: Icons.keyboard, isSelected: false, onSelectionChange: (p0) {})),
            ]),
            const SizedBox(height: BPPresets.big),
            cont(Row(mainAxisSize: MainAxisSize.max, children: [
              IconButton(icon: const Icon(Icons.volume_up), onPressed: () {}),
              Expanded(child: Slider(value: 0.5, onChanged: (p0) {})),
              IconButton(icon: const Icon(Icons.arrow_drop_down), onPressed: () {}),
            ])),
            const SizedBox(height: BPPresets.small),
            cont(Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(icon: const Icon(Icons.brightness_auto), onPressed: () {}),
              Expanded(child: Slider(value: 0.5, onChanged: (p0) {})),
              IconButton(icon: const Icon(Icons.arrow_drop_down), onPressed: () {}),
            ])),
            const SizedBox(height: BPPresets.big),
            cont(Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(icon: const Icon(Icons.battery_full), onPressed: () {}),
              const Spacer(),
              IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
            ])),
          ],
        ),
      ),
    );
  }
}

