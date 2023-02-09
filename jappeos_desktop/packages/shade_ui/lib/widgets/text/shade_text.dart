//  ShadeUI, An UI elements package for JappeOS apps.
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shade_theming/main.dart';

/// Contains different size variants for [ShadeText].
enum ShadeTextStyle { secondary, normal, big, title, title1, title2 }

/// A simple text element.
class ShadeText extends StatefulWidget {
  /// The size variant of the text.
  final ShadeTextStyle? style;

  /// The custom color of the text.
  final Color? customColor;

  /// The custom fontWeight of the text.
  final FontWeight? customFontWeight;

  /// The text.
  final String text;

  const ShadeText({Key? key, this.style, this.customColor, this.customFontWeight, required this.text}) : super(key: key);

  @override
  _ShadeTextState createState() => _ShadeTextState();
}

/// The [State] class for [ShadeText].
class _ShadeTextState extends State<ShadeText> {
  

  @override
  Widget build(BuildContext context) {
    double fontSize = 0.0;
    const double normalFontSize = 10.5;
  
    Color fontColor = context.watch<ShadeThemeProvider>().getCurrentThemeProperties().normalTextColor;
  
    FontWeight fontWeight = FontWeight.normal;

    switch (widget.style) {
      case ShadeTextStyle.secondary:
        fontSize = 10;
        fontColor = context.watch<ShadeThemeProvider>().getCurrentThemeProperties().secondaryTextColor;
        break;
      case ShadeTextStyle.normal:
        fontSize = normalFontSize;
        break;
      case ShadeTextStyle.big:
        fontSize = 13;
        break;
      case ShadeTextStyle.title:
        fontSize = 25;
        fontColor = context.watch<ShadeThemeProvider>().getCurrentThemeProperties().darkerTextColor;
        fontWeight = FontWeight.bold;
        break;
      case ShadeTextStyle.title1:
        fontSize = 20;
        fontColor = context.watch<ShadeThemeProvider>().getCurrentThemeProperties().darkerTextColor;
        fontWeight = FontWeight.bold;
        break;
      case ShadeTextStyle.title2:
        fontSize = 16;
        fontColor = context.watch<ShadeThemeProvider>().getCurrentThemeProperties().darkerTextColor;
        fontWeight = FontWeight.bold;
        break;
      case null:
        fontSize = normalFontSize;
        break;
    }

    return Text(
      widget.text,
      style: TextStyle(
        fontSize: fontSize * 1.5,
        color: widget.customColor ?? fontColor,
        fontWeight: widget.customFontWeight ?? fontWeight,
      ),
    );
  }
}
