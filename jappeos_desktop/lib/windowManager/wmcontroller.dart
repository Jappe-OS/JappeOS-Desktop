import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jappeos_desktop/applications/settings/settings-redesign.dart';
import '../components/apps.dart';
import '../components/cwidgets.dart';
import 'wmresizablewindow.dart';

class WmController {
  WmController(this._onUpdate);

  // Resizable window
  List<ResizableWindow> _resizablewindows = List.empty(growable: true);
  List<ResizableWindow> get resizablewindows => _resizablewindows;

  VoidCallback _onUpdate;

  // Jappeos window spawner
  void wm$spawn_gui_window(Apps arg0) {
    if (arg0 == Apps.SETTINGS) {
      wm$gui_spawn_sysapp_window("Settings", WifiPage(), JAppMainSearchBox(
                                      jbgtext: 'Search settings...',
                                    ),);
    }
  }

  void wm$gui_spawn_sysapp_window(String title, Widget sysappwidget, Widget leftItem) {
    _createNewWindowedApp(title, sysappwidget, leftItem);
  }

  void addWindow() {
    addWindowContent();
  }

  void addWindowContent() {
    _createNewWindowedApp(
      "Title",
      Container(
        color: Colors.black.withOpacity(0.5),
      ),
      Container(),
    );
  }

  void _createNewWindowedApp(String title, Widget app, Widget leftItem) {
    ResizableWindow resizableWindow = ResizableWindow(title, app, leftItem);

    //Set initial position
    var rng = new Random();
    resizableWindow.x = rng.nextDouble() * 500;
    resizableWindow.y = rng.nextDouble() * 500;

    //Init onWindowDragged
    resizableWindow.onWindowDragged = (dx, dy) {
      resizableWindow.x += dx;
      resizableWindow.y += dy;

      //Put on top of stack
      _resizablewindows.remove(resizableWindow);
      _resizablewindows.add(resizableWindow);

      _onUpdate();
    };

    //Init onCloseButtonClicked
    resizableWindow.onCloseButtonClicked = () {
      _resizablewindows.remove(resizableWindow);
      _onUpdate();
    };

    //Add Window to List
    _resizablewindows.add(resizableWindow);

    // Update Widgets after adding the new App
    _onUpdate();
  }
}

class AppID {

}
