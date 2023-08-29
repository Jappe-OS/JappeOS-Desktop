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

class PermissionsMenu extends DesktopMenu {
  final List<_ExpansionPanelListItem> _data = [
    _ExpansionPanelListItem(expandedValues: ["Google Chrome", "Discord"], headerValue: "Microphone", headerIcon: Icons.mic),
    _ExpansionPanelListItem(expandedValues: ["Google Chrome", "Discord"], headerValue: "Camera", headerIcon: Icons.camera),
  ];

  @override
  Widget getContents(BuildContext context) {
    return Padding(
      padding: defaultPadding,
      child: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _data[index].isExpanded = !isExpanded;
            });
          },
          children: _data.map<ExpansionPanel>((_ExpansionPanelListItem item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  leading: Icon(item.headerIcon),
                  title: Text(item.headerValue),
                );
              },
              body: Text(item.expandedValues.join("\n")),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  DesktopMenuPosition getPos() => DesktopMenuPosition.right;

  @override
  Size? getSize() => const Size(400, 400);
}

class _ExpansionPanelListItem {
  _ExpansionPanelListItem({
    required this.expandedValues,
    required this.headerIcon,
    required this.headerValue,
    this.isExpanded = false,
  });

  List<String> expandedValues;
  IconData headerIcon;
  String headerValue;
  bool isExpanded;
}
