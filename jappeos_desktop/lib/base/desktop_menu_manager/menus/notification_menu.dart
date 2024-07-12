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

// ignore_for_file: library_private_types_in_public_api

part of jappeos_desktop.base;

class NotificationMenu extends DesktopMenu {
  const NotificationMenu({Key? key}) : super(key: key);

  @override
  _NotificationMenuState createState() => _NotificationMenuState();
}

class _NotificationMenuState extends State<NotificationMenu> {
  static const kDefaultPadding = BPPresets.medium;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CalendarDatePicker(initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(9000), onDateChanged: (p0) {}),
          const Divider(),
          OutlinedButton(onPressed: () {}, child: const Text("Clear All")),
          const SizedBox(height: 5),
          const _NotificationCard(title: "Title", contentText: "Content Text"),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatefulWidget {
  final String title;
  final String contentText;

  const _NotificationCard({required this.title, required this.contentText});

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<_NotificationCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovered = false;
        });
      },
      child: AdvancedContainer(
        width: double.infinity,
        background: AdvancedContainerBackground.transparentBackground,
        borderStyle: hovered ? AdvancedContainerBorder.single : AdvancedContainerBorder.none,
        borderRadius: BPPresets.medium,
        blur: true,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(child: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold))),
                if (hovered)
                  GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.close,
                        size: 20,
                      )),
              ]),
              Text(widget.contentText),
            ],
          ),
        ),
      ),
    );
  }
}
