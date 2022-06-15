import 'dart:io';

import 'package:jappeos_desktop/system/appSystem/application.dart';

enum SystemApps { SYSTEM_TestApp, SYSTEM_Settings }

class Applications {
  /*static void sys$runProcess(SystemApps app) {
    switch (app) {
      case SystemApps.SYSTEM_TestApp:
        TestApp.app$launch();
        break;
      case SystemApps.SYSTEM_Settings:
        Settings.app$launch();
        break;
    }
  }*/

  static final List<Application>? _JappeOSprocessList = [];

  static void sys$runProcess(Application application) {
    application.app$launch();
    _JappeOSprocessList?.add(application);
  }

  static void sys$killProcess(Application application) {
    application.app$kill();
    _JappeOSprocessList?.remove(application);
  }

  static Application sys$getProcess(Application application) {
    return application;
  }
}
