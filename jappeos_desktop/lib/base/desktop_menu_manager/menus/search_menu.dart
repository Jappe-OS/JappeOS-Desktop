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

class SearchMenu extends DesktopMenu {
  @override
  Widget getContents(BuildContext context) {
    return Padding(padding: defaultPadding, child: Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(width: 400, child: TextField(
        decoration: InputDecoration(
          hintText: "Search Files, Apps & More",
          fillColor: JappeOsDesktopUI.theme_customGlassFieldBgColor(context),
          border: const OutlineInputBorder(),
          isDense: true,
          contentPadding: const EdgeInsets.all(12),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 0.7, color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1.7, color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(30),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),),
      Padding(padding: const EdgeInsets.only(top: 5, bottom: 5), child: Container(height: 1, width: 400, color: JappeOsDesktopUI.theme_customBorderColor(context),),),
      const DeuiText(isTitle: false, text: "Results will be shown here."),
    ],),);
  }

  @override
  DesktopMenuPosition getPos() => DesktopMenuPosition.center;

  @override
  Size? getSize() => null;
}
