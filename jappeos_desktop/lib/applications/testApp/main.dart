import 'package:flutter/material.dart';
import 'package:jappeos_desktop/system/appSystem/application.dart';
import 'package:jappeos_desktop/desktop.dart';

class TestApp extends Application {
  TestApp() : super("TestApp", "testapp", null);

  static void app$launch() {
    Widget body() {
      return Container();
    }

    ;

    Widget cwd() {
      return Container();
    }

    ;

    //DesktopState dm;
    DesktopState.wmController?.wm$spawn_gui_window("TestApp", body(), cwd());
  }
}
