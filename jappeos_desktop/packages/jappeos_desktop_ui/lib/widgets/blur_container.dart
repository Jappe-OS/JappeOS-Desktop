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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jappeos_desktop_ui/jappeos_desktop_ui.dart';
import 'package:shade_theming/main.dart';

class BorderRadiusSides {
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  BorderRadiusSides(this.topLeft, this.topRight, this.bottomLeft, this.bottomRight);
}

/// A container with a blurred background.
class DeuiBlurContainer extends StatefulWidget {
  /// The child inside the widget.
  final Widget child;

  /// Adds a nice gradient & glassy effect to the blur.
  final bool? gradient;

  /// Whether to show a border or not.
  final bool? bordered;

  /// The width of the widget.
  final double? width;

  /// The height of the widget.
  final double? height;

  /// Toggle border radius on different corners.
  final BorderRadiusSides? radiusSides;

  const DeuiBlurContainer({Key? key, required this.child, this.gradient, this.bordered, this.width, this.height, this.radiusSides}) : super(key: key);

  @override
  _DeuiBlurContainerState createState() => _DeuiBlurContainerState();
}

/// The [State] class for [DeuiBlurContainer].
class _DeuiBlurContainerState extends State<DeuiBlurContainer> {
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry brg = BorderRadius.only(
      topLeft: widget.radiusSides!.topLeft ? Radius.circular(JappeOsDesktopUI.getDefaultBorderRadius()) : Radius.zero,
      topRight: widget.radiusSides!.topRight ? Radius.circular(JappeOsDesktopUI.getDefaultBorderRadius()) : Radius.zero,
      bottomLeft: widget.radiusSides!.bottomLeft ? Radius.circular(JappeOsDesktopUI.getDefaultBorderRadius()) : Radius.zero,
      bottomRight: widget.radiusSides!.bottomRight ? Radius.circular(JappeOsDesktopUI.getDefaultBorderRadius()) : Radius.zero,
    );

    List<Color> gradientColors() {
      if (ShadeTheme.getTheme() == 0) {
        return [const Color.fromRGBO(255, 255, 255, 0.6), const Color.fromRGBO(255, 255, 255, 0.102)];
      } else {
        return [const Color.fromRGBO(0, 0, 0, 0.6), const Color.fromRGBO(0, 0, 0, 0.102)];
      }
    }

    return ClipRRect(
      borderRadius: brg,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            image: const DecorationImage(image: AssetImage("resources/images/blur_noise.png"), fit: BoxFit.cover, opacity: 0.2),
            gradient: (widget.gradient ?? false) ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: gradientColors(),
            ) : null,
            borderRadius: brg,
            border: (widget.bordered ?? false) ? Border.all(width: 2, color: ShadeTheme.getCurrentThemeProperties().borderColor) : null,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
