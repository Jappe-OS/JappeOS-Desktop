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

part of jappeos_desktop.base;

/// A basic widget that has the logo of an app and also the name below.
class DApplicationItem extends StatefulWidget {
  final SvgPicture image;
  final String? title;
  final void Function()? onPress;

  const DApplicationItem._({
    Key? key,
    required this.image,
    this.title,
    this.onPress,
  }) : super(key: key);

  factory DApplicationItem.icon({required SvgPicture image, void Function()? onPress}) {
    return DApplicationItem._(image: image, onPress: onPress);
  }

  factory DApplicationItem.iconWithTitle({required SvgPicture image, required String? title, void Function()? onPress}) {
    return DApplicationItem._(image: image, title: title, onPress: onPress);
  }

  @override
  _DApplicationItemState createState() => _DApplicationItemState();
}

class _DApplicationItemState extends State<DApplicationItem> {
  bool isHovering = false;
  final borderRad = BorderRadius.circular(BPPresets.small);
  final borderWidth = 1.0;

  late final width = widget.title != null ? 90.0 : 80.0;
  late final height = widget.title != null ? 100.0 : 80.0;

  @override
  Widget build(BuildContext context) {
    //return Container(
    //  height: 100,
    //  width: 90,
    //  decoration: BoxDecoration(
    //    borderRadius: BorderRadius.circular(JappeOsDesktopUI.getDefaultBorderRadiusRedc()),
    //    // Only show border when hovering.
    //    border: isHovering
    //        ? Border.all(
    //            width: JappeOsDesktopUI.theme_defaultBorderSize(),
    //            color: JappeOsDesktopUI.theme_customBorderColor(context),
    //          )
    //        : null,
    //    //color: SHUI_THEME_PROPERTIES(ctx).backgroundColor1.withOpacity(SHUI_OPTIMAL_ELEMENT_OPACITY),
    //  ),
    //  child: Material(
    //    color: Colors.transparent,
    //    child: InkWell(
    //      mouseCursor: SystemMouseCursors.alias,
    //      hoverColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
    //      splashColor: Theme.of(context).colorScheme.background.withOpacity(0.25),
    //      highlightColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
    //      borderRadius: BorderRadius.circular(JappeOsDesktopUI.getDefaultBorderRadiusRedc()),
    //      onHover: (value) => setState(() => isHovering = value),
    //      onTap: widget.onPress,
    //      child: Padding(
    //        padding: const EdgeInsets.all(5),
    //        child: Column(
    //          children: [
    //            // The image/logo of app.
    //            Expanded(child: widget.image),
    //            // The name of the app.
    //            Text(
    //              widget.title,
    //              style: TextStyle(color: Theme.of(context).textTheme.labelMedium?.color, shadows: const [Shadow(blurRadius: 3)]),
    //            ),
    //          ],
    //        ),
    //      ),
    //    ),
    //  ),
    //);
    final accentColor = Theme.of(context).colorScheme.primary;
    final borderColor = Theme.of(context).colorScheme.outline;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRad,
        color: Colors.transparent,
        border: isHovering ? Border.all(width: borderWidth, color: borderColor) : Border.all(width: borderWidth, color: Colors.transparent),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          mouseCursor: SystemMouseCursors.alias,
          hoverColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
          splashColor: accentColor.withOpacity(0.25),
          highlightColor: accentColor.withOpacity(0.1),
          borderRadius: borderRad,
          onTap: widget.onPress,
          onHover: (value) => setState(() {
            isHovering = value;
          }),
          child: Column(
            children: [
              Expanded(child: widget.image),
              if (widget.title != null) ...[
                const SizedBox(height: BPPresets.small),
                Tooltip(message: widget.title, child: Text(widget.title!, overflow: TextOverflow.ellipsis, maxLines: 1)),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

/// A wrapper around [AdvancedContainer] that is used for the overlay menus of the desktop.
class DMenuContainer extends StatefulWidget {
  final double? width, height;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  const DMenuContainer({super.key, required this.child, this.width, this.height, this.padding});

  @override
  _DMenuContainerState createState() => _DMenuContainerState();
}

class _DMenuContainerState extends State<DMenuContainer> {
  @override
  Widget build(BuildContext context) {
    return AdvancedContainer(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      background: AdvancedContainerBackground.transparentBackground,
      borderStyle: AdvancedContainerBorder.double,
      borderRadius: BPPresets.medium,
      blur: true,
      child: widget.child,
    );
  }
}

/// A topbar button that opens a desktop menu.
class DTopbarButton extends StatefulWidget {
  final String? title;
  final List<Widget> children;
  final DesktopMenuController menuControllerRef;
  final DesktopMenu menu;

  final AlignmentGeometry alignment;

  const DTopbarButton._(
      {Key? key, this.title, this.children = const [], required this.menuControllerRef, required this.menu, this.alignment = Alignment.center})
      : super(key: key);

  factory DTopbarButton.text({
    required String text,
    required DesktopMenuController menuControllerRef,
    required DesktopMenu menu,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return DTopbarButton._(
      menuControllerRef: menuControllerRef,
      menu: menu,
      alignment: alignment,
      title: text,
    );
  }

  factory DTopbarButton.icon({
    required IconData icon,
    required DesktopMenuController menuControllerRef,
    required DesktopMenu menu,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return DTopbarButton._(
      menuControllerRef: menuControllerRef,
      menu: menu,
      alignment: alignment,
      children: [Icon(icon)],
    );
  }

  factory DTopbarButton.icons({
    required List<IconData> icons,
    required DesktopMenuController menuControllerRef,
    required DesktopMenu menu,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return DTopbarButton._(
      menuControllerRef: menuControllerRef,
      menu: menu,
      alignment: alignment,
      children: [
        for (var icon in icons) Icon(icon),
      ],
    );
  }

  factory DTopbarButton.textAndIcon({
    required String text,
    required IconData icon,
    required DesktopMenuController menuControllerRef,
    required DesktopMenu menu,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return DTopbarButton._(
      menuControllerRef: menuControllerRef,
      menu: menu,
      alignment: alignment,
      title: text,
      children: [Icon(icon)],
    );
  }

  @override
  _DTopbarButtonState createState() => _DTopbarButtonState();
}

class _DTopbarButtonState extends State<DTopbarButton> {
  Offset globalPosition = Offset.zero;

  bool hovering = false;
  final borderRad = BorderRadius.circular(100);
  final borderWidth = 1.0;

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.primary;
    final borderColor = Theme.of(context).colorScheme.outline;

    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 2),
      alignment: widget.alignment,
      height: 26,
      decoration: BoxDecoration(
        borderRadius: borderRad,
        color: Colors.transparent,
        border: hovering ? Border.all(width: borderWidth, color: borderColor) : Border.all(width: borderWidth, color: Colors.transparent),
      ),
      child: RepaintBoundary(
        child: Builder(
          builder: (context) {
            // Add a post frame callback to ensure the widget has been laid out
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Get the RenderBox of the widget
              final renderBox = context.findRenderObject() as RenderBox;

              // Get the global position of the widget
              globalPosition = renderBox.localToGlobal(Offset.zero);
            });

            return Material(
              color: Colors.transparent,
              child: InkWell(
                mouseCursor: SystemMouseCursors.alias,
                hoverColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
                splashColor: accentColor.withOpacity(0.25),
                highlightColor: accentColor.withOpacity(0.1),
                borderRadius: borderRad,
                onTap: () {
                  widget.menuControllerRef.openMenu(
                    widget.menu,
                    globalPosition,
                  );
                },
                onHover: (value) => setState(() {
                  hovering = value;
                }),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.title != null) Text(widget.title!),
                      ...widget.children,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// A background widget for desktop menus.
class DMenuBackground extends StatelessWidget {
  final Widget child;
  final double? width, height;

  const DMenuBackground({Key? key, required this.child, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdvancedContainer(
      width: width,
      height: height,
      borderStyle: AdvancedContainerBorder.double,
      background: AdvancedContainerBackground.transparentBackground,
      blur: true,
      borderRadius: BPPresets.medium,
      child: child,
    );
  }
}
