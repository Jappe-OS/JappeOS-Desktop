import 'package:flutter/material.dart';

abstract class Application {
  final String s_displayName;
  final String s_id;
  final Image i_icon;

  Application(
      this.s_displayName, this.s_id, this.i_icon);

  //void app$launch() {}
}
