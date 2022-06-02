import 'dart:math';
import 'package:flutter/material.dart';
import 'wmresizablewindow.dart';

class WmController {
  WmController(this._onUpdate);

  // Resizable window
  List<ResizableWindow> _resizablewindows = List.empty(growable: true);
  List<ResizableWindow> get resizablewindows => _resizablewindows;

  VoidCallback _onUpdate;

  // Jappeos window spawner
  void wm$spawn_gui_window(String title, Widget body, Widget cwd) {
    _createNewWindowedApp(title, body, cwd);
  }

  void addWindow() {
    addWindowContent();
  }

  void addWindowContent() {
    _createNewWindowedApp("Main Window", Container(), Container());
  }

  void _createNewWindowedApp(String title, Widget body, Widget cwd) {
    ResizableWindow resizableWindow = ResizableWindow(title, body, cwd);

    // Set initial position
    var rng = new Random();
    resizableWindow.x = rng.nextDouble() * 500;
    resizableWindow.y = rng.nextDouble() * 500;

    // Init onWindowDragged
    resizableWindow.onWindowDragged = (dx, dy) {
      var x1 = resizableWindow.x;
      var y1 = resizableWindow.y;

      if (x1 != null)
        x1 += dx;

      if (y1 != null)
        y1 += dy;


      resizableWindow.x = x1;
      resizableWindow.y = y1;

      // Put on top of stack
      _resizablewindows.remove(resizableWindow);
      _resizablewindows.add(resizableWindow);

      _onUpdate();
    };

    // Init onCloseButtonClicked
    resizableWindow.onCloseButtonClicked = () {
      _resizablewindows.remove(resizableWindow);
      _onUpdate();
    };

    // Add Window to List
    _resizablewindows.add(resizableWindow);

    // Update Widgets after adding the new App
    _onUpdate();
  }
}
