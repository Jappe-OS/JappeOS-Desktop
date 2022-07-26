//  JappeOS-Desktop, The desktop environment for JappeOS.
//  Copyright (C) 2022  Jappe02
//  
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Affero General Public License as
//  published by the Free Software Foundation, either version 3 of the
//  License, or (at your option) any later version.
//  
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Affero General Public License for more details.
//  
//  You should have received a copy of the GNU Affero General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:jappeos_desktop/system/appSystem/application.dart';
import 'package:jappeos_desktop/desktop.dart';
import 'package:jappeos_desktop/system/appSystem/iApplication.dart';

class TestApp extends Application implements IApplication {
  TestApp() : super("TestApp", "testapp", null);

  void app$launch() {
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

  Widget? body() {
    // TODO: implement body
    throw UnimplementedError();
  }

  Widget? cwd() {
    // TODO: implement cwd
    throw UnimplementedError();
  }
}
