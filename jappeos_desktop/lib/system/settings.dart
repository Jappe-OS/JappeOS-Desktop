import 'package:jappeos_desktop/windowManager/wmresizablewindow.dart';

class Settings {
  static Settings JAPPEOS_SETTINGS_INSTANCE = new Settings();

  //
  ColorMode _colorMode = ColorMode.DARK;

  ColorMode getColorMode() {
    return _colorMode;
  }

  void setColorMode(ColorMode colorMode) {
    _colorMode = colorMode;
  }
}

enum ColorMode { DARK, LIGHT }
