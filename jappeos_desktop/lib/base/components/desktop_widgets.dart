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

part of base;

/// A basic widget that has the logo of an app and also the name below.
class DApplicationItem extends StatefulWidget {
  final SvgPicture image;
  final String title;
  final void Function()? onPress;

  const DApplicationItem(this.image, this.title, this.onPress, {Key? key}) : super(key: key);

  @override
  _DApplicationItemState createState() => _DApplicationItemState();
}

class _DApplicationItemState extends State<DApplicationItem> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(JappeOsDesktopUI.getDefaultBorderRadiusRedc()),
        // Only show border when hovering.
        border: isHovering ? Border.all(
          width: JappeOsDesktopUI.theme_defaultBorderSize(),
          color: JappeOsDesktopUI.theme_customBorderColor(context),
        ) : null,
        //color: SHUI_THEME_PROPERTIES(ctx).backgroundColor1.withOpacity(SHUI_OPTIMAL_ELEMENT_OPACITY),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          mouseCursor: SystemMouseCursors.alias,
          hoverColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
          splashColor: Theme.of(context).colorScheme.background.withOpacity(0.25),
          highlightColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
          borderRadius: BorderRadius.circular(JappeOsDesktopUI.getDefaultBorderRadiusRedc()),
          onHover: (value) => setState(() => isHovering = value),
          onTap: widget.onPress,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                // The image/logo of app.
                Expanded(child: widget.image),
                // The name of the app.
                Text(
                  widget.title,
                  style: TextStyle(color: Theme.of(context).textTheme.labelMedium?.color, shadows: const [Shadow(blurRadius: 3)]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
