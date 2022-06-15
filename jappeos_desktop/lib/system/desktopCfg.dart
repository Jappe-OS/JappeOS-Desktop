import 'package:flutter/material.dart';

class DesktopCfg {
  static DesktopCfg DESKTOPCFG_INSTANCE = new DesktopCfg();

  // --- [de-info]

  /// Get the name of the desktop.
  final String de_NAME = "jappe-os desktop";

  /// Get the version of the desktop.
  final String de_VERSION = "alpha: 1.1.3";

  // --- [theme stuff]

  /// The blur color for the dark theme of the desktop. [blur colors]
  final Color dsktp_BLUR_COLOR_DARK = Colors.black.withOpacity(0.5);

  /// The blur color for the light theme of the desktop.
  final Color dsktp_BLUR_COLOR_LIGHT = Colors.white.withOpacity(0.5);

  /// The background blur color for the dark theme of the desktop. [blur color background]
  final Color dsktp_BLUR_COLOR_DARK_BG = Color.fromARGB(167, 27, 27, 27);

  /// The background blur color for the light theme of the desktop. [blur color background]
  final Color dsktp_BLUR_COLOR_LIGHT_BG = Color.fromARGB(167, 206, 206, 206);

  /// The normal text color for the light theme of the desktop. [text color]
  final dsktp_TEXT_COLOR_LIGHT = Color(0xFFFFFFFF);

  /// The normal text color for the dark theme of the desktop. [text color]
  final dsktp_TEXT_COLOR_DARK = Color(0xFF000000);

  /// Get the default JappeOS UI theme color as a Color [accent color]
  Color? getJappeosThemeColor(JappeOsColor arg0) {
    switch (arg0) {
      case JappeOsColor.BLUE:
        {
          return Colors.blueAccent;
        }
      case JappeOsColor.YELLOW:
        {
          return Colors.yellowAccent;
        }
      case JappeOsColor.GREEN:
        {
          return Colors.greenAccent;
        }
      case JappeOsColor.RED:
        {
          return Colors.redAccent;
        }
      case JappeOsColor.DEFAULT:
        {
          return Colors.blueAccent;
        }
    }
    return null;
  }

  // OLD
  /*final dsktp_ACCENT_COLOR = Colors.blueAccent;
  final dsktp_SECONDARY_ACCENT_COLOR = Color(0xFFCFCFCF);
  */

  // desktop wallpaper
  final String dsktpWallpaper =
      "lib/images/desktop/backgrounds/wallpaper2.jpg"; // This should get the picture from a local folder in the future or something.

}

enum JappeOsColor { DEFAULT, BLUE, YELLOW, GREEN, RED }
