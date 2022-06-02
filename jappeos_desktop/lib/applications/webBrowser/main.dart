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
