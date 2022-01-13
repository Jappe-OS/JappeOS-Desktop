import 'package:flutter/material.dart';
import 'package:jappeos_desktop/components/cwidgets.dart';

class Functions {
  static void gui_spawn_fullscreen_error_dialog(BuildContext arg0, String arg1) {
    Navigator.push(
        arg0, MaterialPageRoute(builder: (context) => JFullscreenErrorDialog(arg0: arg0, arg1: arg1,)));
  }
}
