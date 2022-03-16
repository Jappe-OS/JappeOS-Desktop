// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jappeos_desktop/components/consts.dart';

class ResizableWindow extends StatefulWidget {
  double currentHeight, defaultHeight = 400.0;
  double currentWidth, defaultWidth = 400.0;
  double x;
  double y;
  String title;
  Widget body;
  Widget cwd;

  Function(double, double) onWindowDragged;
  VoidCallback onCloseButtonClicked;

  ResizableWindow(this.title, this.body, this.cwd) : super(key: UniqueKey()) {
    currentHeight = defaultHeight;
    currentWidth = defaultWidth;
  }

  @override
  _ResizableWindowState createState() => _ResizableWindowState();
}

class _ResizableWindowState extends State<ResizableWindow> {
  var _headerSize = 40.0;
  var _borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(115, 0, 0, 0),
            spreadRadius: 4,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        child: Stack(
          children: [
            Column(
              children: [_getHeader(), _getBody()],
            ),
            Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragRight,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    opaque: true,
                    child: Container(
                      width: 4,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragLeft,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    opaque: true,
                    child: Container(
                      width: 4,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragUpdate: _onHorizontalDragTop,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    opaque: true,
                    child: Container(
                      height: 4,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragUpdate: _onHorizontalDragBottom,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    opaque: true,
                    child: Container(
                      height: 4,
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onPanUpdate: _onHorizontalDragBottomRight,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    opaque: true,
                    child: Container(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                left: 0,
                child: GestureDetector(
                  onPanUpdate: _onHorizontalDragBottomLeft,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    opaque: true,
                    child: Container(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
            Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onPanUpdate: _onHorizontalDragTopRight,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    opaque: true,
                    child: Container(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                child: GestureDetector(
                  onPanUpdate: _onHorizontalDragTopLeft,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    opaque: true,
                    child: Container(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _getHeader() {
    return GestureDetector(
      onPanUpdate: (tapInfo) {
        widget.onWindowDragged(tapInfo.delta.dx, tapInfo.delta.dy);
      },
      child: blurContainer(
        Container(
          width: widget.currentWidth,
          height: _headerSize + 1,
          child: Stack(
            children: [
              Positioned(
                top: 4,
                right: 7,
                bottom: 4,
                //width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.minimize_rounded, color: Colors.white.withOpacity(0.7)),
                      iconSize: 20,
                      onPressed: () {
                        
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.crop_square_rounded, color: Colors.white.withOpacity(0.7)),
                      iconSize: 20,
                      onPressed: () {
                        
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.close_rounded, color: Colors.white.withOpacity(0.7)),
                      iconSize: 20,
                      onPressed: () {
                        widget.onCloseButtonClicked();
                      },
                    ),
                  ],
                ),
              ),
              /*Positioned(
                right: 7,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    widget.onCloseButtonClicked();
                  },
                ),
              ),
              Positioned(
                right: 39,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: Icon(Icons.crop_square, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              Positioned(
                right: 71,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: Icon(Icons.minimize, color: Colors.white),
                  onPressed: () {},
                ),
              ),*/
              Positioned.fill(
                  child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 18, color: dsktp_TEXT_COLOR_LIGHT),
                ),
              )),
              Positioned(
                  top: 4,
                  left: 7,
                  bottom: 0,
                  right: 120,
                  child: widget.cwd),
            ],
          ),
        ),
      ),
    );
  }

  _getBody() {
    return Container(
      width: widget.currentWidth,
      height: widget.currentHeight - _headerSize,
      color: Colors.transparent,
      child: blurContainer(
        widget.body,
      ),
    );
  }

  void _onHorizontalDragLeft(DragUpdateDetails details) {
    setState(() {
      widget.currentWidth -= details.delta.dx;
      if (widget.currentWidth < widget.defaultWidth) {
        widget.currentWidth = widget.defaultWidth;
      } else {
        widget.onWindowDragged(details.delta.dx, 0);
      }
    });
  }

  void _onHorizontalDragRight(DragUpdateDetails details) {
    setState(() {
      widget.currentWidth += details.delta.dx;
      if (widget.currentWidth < widget.defaultWidth) {
        widget.currentWidth = widget.defaultWidth;
      }
    });
  }

  void _onHorizontalDragBottom(DragUpdateDetails details) {
    setState(() {
      widget.currentHeight += details.delta.dy;
      if (widget.currentHeight < widget.defaultHeight) {
        widget.currentHeight = widget.defaultHeight;
      }
    });
  }

  void _onHorizontalDragTop(DragUpdateDetails details) {
    setState(() {
      widget.currentHeight -= details.delta.dy;
      if (widget.currentHeight < widget.defaultHeight) {
        widget.currentHeight = widget.defaultHeight;
      } else {
        widget.onWindowDragged(0, details.delta.dy);
      }
    });
  }

  void _onHorizontalDragBottomRight(DragUpdateDetails details) {
    _onHorizontalDragRight(details);
    _onHorizontalDragBottom(details);
  }

  void _onHorizontalDragBottomLeft(DragUpdateDetails details) {
    _onHorizontalDragLeft(details);
    _onHorizontalDragBottom(details);
  }

  void _onHorizontalDragTopRight(DragUpdateDetails details) {
    _onHorizontalDragRight(details);
    _onHorizontalDragTop(details);
  }

  void _onHorizontalDragTopLeft(DragUpdateDetails details) {
    _onHorizontalDragLeft(details);
    _onHorizontalDragTop(details);
  }

  // Blur effects
  Widget blurContainer(Widget child) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
        child: Container(
          width: widget.currentWidth,
          height: _headerSize,
          color: dsktp_BLUR_COLOR_DARK_WINDOW,
          child: child,
        ),
      ),
    );
  }
}
