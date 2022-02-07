import 'package:flutter/material.dart';
import 'package:jappeos_desktop/components/consts.dart';

// JAPPEOS NORMAL BUTTON - TEXT

class JNormalTextButton extends StatefulWidget {
  final VoidCallback onPress;
  final String text;

  JNormalTextButton({Key key, @required this.onPress, @required this.text})
      : super(key: key);

  _JNormalTextButton createState() => _JNormalTextButton();
}

class _JNormalTextButton extends State<JNormalTextButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        widget.text,
        style: TextStyle(color: dsktp_TEXT_COLOR_LIGHT),
      ),
      style: ElevatedButton.styleFrom(
        primary: dsktp_ACCENT_COLOR,
      ),
      onPressed: widget.onPress,
    );
  }
}

// JAPPEOS NORMAL BUTTON - TEXT

class JSecondaryTextButton extends StatefulWidget {
  final VoidCallback onPress;
  final String text;

  JSecondaryTextButton({Key key, @required this.onPress, @required this.text})
      : super(key: key);

  _JSecondaryTextButton createState() => _JSecondaryTextButton();
}

class _JSecondaryTextButton extends State<JSecondaryTextButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        widget.text,
        style: TextStyle(color: dsktp_TEXT_COLOR_DARK),
      ),
      style: ElevatedButton.styleFrom(
        primary: dsktp_SECONDARY_ACCENT_COLOR,
      ),
      onPressed: widget.onPress,
    );
  }
}