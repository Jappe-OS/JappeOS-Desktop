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


import 'package:flutter/material.dart';

class WebBrowserMain extends StatefulWidget {
  WebBrowserMain({Key? key, required this.title}) : super(key: key);

  final String title;
  static final String wm$windowData_Title = "";
  static final Widget wm$windowData_CustomBar = new Container(
    height: 30,
    constraints: BoxConstraints.expand(),
    margin: EdgeInsets.only(right: 100),
    child: Stack(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {}
            )
          ],
        )
      ],
    ),
  );

  @override
  _WebBrowserMainState createState() => _WebBrowserMainState();
}

class _WebBrowserMainState extends State<WebBrowserMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
    );
  }
}
