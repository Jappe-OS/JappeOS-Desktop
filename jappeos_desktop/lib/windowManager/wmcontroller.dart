import 'dart:math';

import 'package:flutter/material.dart';

import 'wmresizablewindow.dart';

class WmController{

  WmController(this._onUpdate);


  List<ResizableWindow> _windows = List.empty(growable: true);

  VoidCallback _onUpdate;


  List<ResizableWindow> get windows => _windows;


  void addWindow(){
    addWindowContent();
  }


  void addWindowContent(){

    _createNewWindowedApp("Title", Container());

  }

  void _createNewWindowedApp(String title,Widget app){


    ResizableWindow resizableWindow = ResizableWindow(title,app);


    //Set initial position
    var rng = new Random();
    resizableWindow.x =  rng.nextDouble() * 500;
    resizableWindow.y =  rng.nextDouble() * 500;

    //Init onWindowDragged
    resizableWindow.onWindowDragged = (dx,dy){

      resizableWindow.x += dx;
      resizableWindow.y += dy;

      //Put on top of stack
      _windows.remove(resizableWindow);
      _windows.add(resizableWindow);

      _onUpdate();


    };

    //Init onCloseButtonClicked
    resizableWindow.onCloseButtonClicked = (){
      _windows.remove(resizableWindow);
      _onUpdate();
    };


    //Add Window to List
    _windows.add(resizableWindow);

    // Update Widgets after adding the new App
    _onUpdate();

  }
}