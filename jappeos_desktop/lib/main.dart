import 'package:flutter/material.dart';
import 'package:jappeos_desktop/system/desktopCfg.dart';
import 'desktop.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(JappeOsDesktop());
}

/// This is the main class of the JappeOS Desktop, you may not access it.
/// 
/// Made by Jappe. (2020 - 2022)
class JappeOsDesktop extends StatelessWidget {

  // Whether the theme is light or dark.
  final bool _isLight = DesktopCfg.DESKTOPCFG_INSTANCE.getColorMode() == ColorMode.LIGHT ? true : false;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jappeos_desktop',
      debugShowCheckedModeBanner: false,
      theme: _isLight ? _lightTheme : _darkTheme,
      home: Desktop(),
    );
  }

  // ThemeData for light theme.
  final ThemeData _lightTheme = ThemeData(
    visualDensity: VisualDensity.standard,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: DesktopCfg.DESKTOPCFG_INSTANCE.getJappeosThemeColor(JappeOsColor.DEFAULT), brightness: Brightness.light),
    
  );

  // ThemeData for dark theme.
  final ThemeData _darkTheme = ThemeData(
    visualDensity: VisualDensity.standard,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: DesktopCfg.DESKTOPCFG_INSTANCE.getJappeosThemeColor(JappeOsColor.DEFAULT), brightness: Brightness.dark),
    
  );
}
