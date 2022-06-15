import 'dart:ui';

import 'package:flutter/material.dart';

class JDesktopWindow extends StatefulWidget {
  final String? windowTitle;
  final Widget? windowBody;

  JDesktopWindow({Key? key, this.windowTitle, this.windowBody})
      : super(key: key);

  _JDesktopWindow createState() => _JDesktopWindow();
}

class _JDesktopWindow extends State<JDesktopWindow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: blurContainer(
        Stack(
          children: [
            // Header
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 35,
              child: Row(
                children: [
                  Text(widget.windowTitle ?? ""),
                ],
              ),
            ),

            // Body
            Positioned(
              left: 0,
              right: 0,
              top: 35,
              bottom: 0,
              child: widget.windowBody ??
                  new Container(
                    color: Colors.transparent,
                  ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget blurContainer(Widget child) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
        child: Container(
          /*width: widget.currentWidth,
          height: _headerSize,*/
          color: Colors.white,
          child: child,
        ),
      ),
    );
  }
}
