import 'package:flutter/material.dart';
import 'package:jappeos_desktop/windowManager/wmcontroller.dart';

class WmManager extends StatefulWidget {

  final WmController? wmController;

  const WmManager({Key? key, this.wmController}) : super(key: key);

  @override
  _WmManagerState createState() => _WmManagerState();
}

class _WmManagerState extends State<WmManager> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.wmController!.resizablewindows.map((e){
        return Positioned(
          left: e.x,
          top: e.y,
          child: e,
          key: e.key,
        );
      }).toList()
    );
  }
}