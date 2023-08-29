//  JappeOS-Desktop, The desktop environment for JappeOS.
//  Copyright (C) 2023  Jappe02
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

class ControlCenterMenu extends DesktopMenu {
  @override
  Widget getContents(BuildContext context) {
    return Padding(
      padding: defaultPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(spacing: 20, runSpacing: 30, children: [
            _QuickActionItem(text: "Wi-Fi", icon: Icons.wifi_rounded, selectedInit: false, onPressed: (p0) {}),
            _QuickActionItem(text: "Bluetooth", icon: Icons.bluetooth_rounded, selectedInit: false, onPressed: (p0) {}),
            _QuickActionItem(text: "Battery (full)", icon: Icons.battery_full_rounded, selectedInit: false, onPressed: (p0) {}),
            _QuickActionItem(text: "Do Not Disturb", icon: Icons.do_not_disturb_rounded, selectedInit: false, onPressed: (p0) {}),
            _QuickActionItem(text: "Dark Theme", icon: Icons.dark_mode_rounded, selectedInit: true, onPressed: (p0) {}),
            _QuickActionItem(text: "EN_US", icon: Icons.keyboard_rounded, selectedInit: true, onPressed: (p0) {}),
          ]),
          const Divider(),
          Row(children: [
            IconButton(icon: const Icon(Icons.volume_up), onPressed: () {}),
            Expanded(child: Slider(value: 0.5, onChanged: (p0) {})),
            IconButton(icon: const Icon(Icons.arrow_drop_down), onPressed: () {}),
          ]),
          Row(children: [
            IconButton(icon: const Icon(Icons.brightness_auto), onPressed: () {}),
            Expanded(child: Slider(value: 0.5, onChanged: (p0) {})),
            IconButton(icon: const Icon(Icons.arrow_drop_down), onPressed: () {}),
          ]),
        ],
      ),
    );
  }

  @override
  DesktopMenuPosition getPos() => DesktopMenuPosition.right;

  @override
  Size? getSize() => const Size(400, -1);
}

class _QuickActionItem extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool selectedInit;
  final void Function(bool)? onPressed;

  const _QuickActionItem({required this.text, required this.icon, required this.selectedInit, this.onPressed});

  @override
  _QuickActionItemState createState() => _QuickActionItemState();
}

class _QuickActionItemState extends State<_QuickActionItem> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();

    isSelected = widget.selectedInit;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => setState(() {
            isSelected = !isSelected;
            widget.onPressed!(isSelected);
          }),
          child: Column(children: [
            const SizedBox(height: 5),
            Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).scaffoldBackgroundColor),
                child: Icon(widget.icon, color: isSelected ? Theme.of(context).scaffoldBackgroundColor : null)),
            Text(widget.text, style: const TextStyle(overflow: TextOverflow.ellipsis)),
          ]),
        ),
      ),
    );
  }
}
