import 'package:flutter/material.dart';
import 'package:jappeos_desktop/windowManager/wmcontroller.dart';

class WmManager extends StatefulWidget {

  final WmController mdiController;

  const WmManager({Key key, this.mdiController}) : super(key: key);

  @override
  _WmManagerState createState() => _WmManagerState();
}

class _WmManagerState extends State<WmManager> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.mdiController.windows.map((e){
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