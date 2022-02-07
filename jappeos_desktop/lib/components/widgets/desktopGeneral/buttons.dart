import 'package:flutter/material.dart';

class DE_BUTTON_Taskbar extends StatefulWidget {
  final VoidCallback onPress;
  final IconData icon;

  DE_BUTTON_Taskbar({Key key, @required this.onPress, @required this.icon}) : super(key: key);

  _DE_BUTTON_TaskbarState createState() => _DE_BUTTON_TaskbarState();
}

class _DE_BUTTON_TaskbarState extends State<DE_BUTTON_Taskbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      margin: EdgeInsets.all(5),
      child: TextButton(
        child: Icon(widget.icon, color: Colors.white.withOpacity(0.85)),
        onPressed: widget.onPress,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )
          )
        )
      ),
    );
  }
}
