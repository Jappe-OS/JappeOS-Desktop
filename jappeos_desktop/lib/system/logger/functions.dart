import 'package:jappeos_desktop/system/logger/logType.dart';

class SYSTEM_LoggerFunctions {
  void system$sendLog(SYSTEM_LoggerMsgType type, String message) {
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

    print(logMsg);
  }
}
