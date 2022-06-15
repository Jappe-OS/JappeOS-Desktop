import 'dart:io';

import 'package:jappeos_desktop/system/appSystem/application.dart';

enum SystemApps { SYSTEM_TestApp, SYSTEM_Settings }

class Applications {

  // TODO: Future stuff: Make each application it's own flutter app (linux process on linux). This app/process system will probably not be changed anymore.

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
