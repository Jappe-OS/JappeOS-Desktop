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


import 'package:jappeos_desktop/system/appSystem/application.dart';
import 'package:jappeos_desktop/system/logger/logType.dart';
import 'package:jappeos_desktop/system/logger/logger.dart';

// ignore: constant_identifier_names
enum SystemApps { SYSTEM_TestApp, SYSTEM_Settings }

class Applications {
  // TODO: Future stuff: Make each application it's own flutter app (linux process on linux). This app/process system will probably not be changed anymore.

  static final List<Application> _jappeOSprocessList = [];

  static final _logger = Logger();

  static void sys$runProcess(Application application) {
    if (!_jappeOSprocessList.contains(application)) {
      application.app$launch();
      _jappeOSprocessList.add(application);
      _logger.jappeOsLogger$sendLog(JappeOsLoggerMsgType.INFO, true, "Starting process application:${application.s_id}.");
    } else {
      _logger.jappeOsLogger$sendLog(
          JappeOsLoggerMsgType.WARN, true, "Tried to launch process application:${application.s_id}. But it was already running.");
    }
  }

  static void sys$killProcess(Application application) {
    application.app$kill();
    _jappeOSprocessList.remove(application);
    _logger.jappeOsLogger$sendLog(JappeOsLoggerMsgType.INFO, true, "Killing process application:${application.s_id}.");
  }

  static Application sys$getProcess(Application application) {
    return application;
  }
}
