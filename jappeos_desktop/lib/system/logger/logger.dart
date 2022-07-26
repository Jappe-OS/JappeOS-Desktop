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


import 'package:jappeos_desktop/system/logger/logType.dart';

class Logger {
  late bool _debugMode = false;

  // Sending
  void jappeOsLogger$sendLog(JappeOsLoggerMsgType type, bool debugOnly, String message) {
    DateTime now = DateTime.now();
    String logMsg = " [" +
        now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString() +
        "] " +
        "[main] " +
        "[" +
        type.toString().toUpperCase() +
        "]: " +
        message;

    if (debugOnly) {
      if (_debugMode) print(logMsg);
    } else {
      print(logMsg);
    }
  }

  // Debug Mode
  void jappeOsLogger$setDebugMode(bool debugMode) {
    _debugMode = debugMode;
  }

  bool jappeOsLogger$getDebugMode() {
    return _debugMode;
  }
}
