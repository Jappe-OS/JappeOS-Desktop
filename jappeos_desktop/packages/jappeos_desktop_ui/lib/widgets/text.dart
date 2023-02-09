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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shade_theming/main.dart';

/// A simple text widget.
class DeuiText extends StatefulWidget {
  /// Whether the text is a title or not.
  final bool isTitle;

  /// The text.
  final String text;

  const DeuiText({Key? key, required this.isTitle, required this.text}) : super(key: key);

  @override
  _DeuiTextState createState() => _DeuiTextState();
}

/// The [State] class for [DeuiText].
class _DeuiTextState extends State<DeuiText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        color: context.watch<ShadeThemeProvider>().getCurrentThemeProperties().normalTextColor,
        fontSize: widget.isTitle ? 25 : 15,
      ),
    );
  }
}
