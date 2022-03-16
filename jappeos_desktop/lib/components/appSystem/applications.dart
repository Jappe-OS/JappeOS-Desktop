
import 'package:jappeos_desktop/applications/testApp/main.dart';

enum Apps { 
  SYSTEM_TestApp,
  SYSTEM_Settings
}

class Applications {
  static void sys$runProcess(Apps app) {
    switch (app) {
      case Apps.SYSTEM_TestApp:
        TestApp.app$launch();
        break;
      case Apps.SYSTEM_Settings:
        // TODO: Handle this case.
        break;
    }
  }
}
