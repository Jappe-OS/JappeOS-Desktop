import 'package:flutter/material.dart';
import 'package:jappeos_desktop/system/desktopCfg.dart';
import 'package:jappeos_desktop/system/settings.dart';
import 'desktop.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(JappeOsDesktop());
}

class JappeOsDesktop extends StatelessWidget {
  final bool _isLight = Settings.JAPPEOS_SETTINGS_INSTANCE.getColorMode() == ColorMode.LIGHT ? true : false;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jappeos_desktop',
      debugShowCheckedModeBanner: false,
      theme: _isLight ? _lightTheme : _darkTheme,
      home: Desktop(),
    );
  }

  final ThemeData _lightTheme = ThemeData(
    visualDensity: VisualDensity.standard,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: DesktopCfg.DESKTOPCFG_INSTANCE.getJappeosThemeColor(JappeOsColor.DEFAULT), brightness: Brightness.light),
    
  );

  final ThemeData _darkTheme = ThemeData(
    visualDensity: VisualDensity.standard,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: DesktopCfg.DESKTOPCFG_INSTANCE.getJappeosThemeColor(JappeOsColor.DEFAULT), brightness: Brightness.dark),
    
  );
}
