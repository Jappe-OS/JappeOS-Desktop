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

class NotificationMenu extends DesktopMenu {
  @override
  Widget getContents(BuildContext context) {
    return Padding(
      padding: defaultPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CalendarDatePicker(initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(9000), onDateChanged: (p0) {}),
          const Divider(),
          DeuiButtonBaseGlasshover(
            borderRadius: 55,
            backgroundColorTransp: true,
            //backgroundColor: SHUI_THEME_PROPERTIES(context).backgroundColor1.withOpacity(0.1),
            onPress: () {},
            child: const Center(
              child: DeuiText(isTitle: false, text: "Clear All"),
            ),
          ),
          const SizedBox(height: 5),
          const _NotificationCard(title: "Title", contentText: "Content Text"),
        ],
      ),
    );
  }

  @override
  DesktopMenuPosition getPos() => DesktopMenuPosition.right;

  @override
  Size? getSize() => const Size(400, -1);
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
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: JappeOsDesktopUI.theme_customGlassFieldBgColor(context),
          borderRadius: BorderRadius.circular(JappeOsDesktopUI.getDefaultBorderRadius()),
          border: hovered ? Border.all(color: JappeOsDesktopUI.theme_customBorderColor(context), width: 1, strokeAlign: BorderSide.strokeAlignOutside) : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(child: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold))),
                if (hovered) GestureDetector(
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
