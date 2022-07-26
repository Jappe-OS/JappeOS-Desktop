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

/// This is the logger for the JappeOS desktop environment. You may use
/// this logger instead of `print(Object? object)`.
/// To send a log message use [jappeOsLogger$sendLog].
/// 
/// This logger will allow you to send log messages to the log, it has a
/// feature called `debugMode`, this can be used to enable more debugging
/// features. You can use the [jappeOsLogger$setDebugMode]
/// method to change the state of `debugMode`. To get the state of
/// `debugMode`, [jappeOsLogger$getDebugMode] can be used, it will
/// return a `boolean`
/// 
/// Made by Jappe. (2022)
class Logger {

  /// Get the Logger() instance and use the methods inside it.
  /// 
  /// Made by Jappe. (2022)
  Logger GET = new Logger();

  // Private boolean to know the debug mode.
  late bool _debugMode = false;

  /// Prints a log message into the console.
  /// 
  /// Parameters:
  /// ```dart
  /// - JappeOsLoggerMsgType type // The type/severity of the log message.
  /// - bool debugOnly // If true, the message will only be sent if debugMode is enabled.
  /// - String message // The log message to print.
  /// ```
  /// 
  /// Made by Jappe. (2022)
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

  /// Enables debug mode for the logger.
  /// 
  /// Parameters:
  /// ```dart
  /// - bool debugMode // Whether to enable/disable debugMode.
  /// ```
  /// 
  /// Made by Jappe. (2022)
  void jappeOsLogger$setDebugMode(bool debugMode) {
    _debugMode = debugMode;
  }

  /// Get the state of debugMode.
  /// 
  /// Made by Jappe. (2022)
  bool jappeOsLogger$getDebugMode() {
    return _debugMode;
  }
}
