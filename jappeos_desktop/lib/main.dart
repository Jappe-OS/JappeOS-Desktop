import 'package:flutter/material.dart';
import 'package:jappeos_desktop/components/desktopCfg.dart';
//import 'package:jappeos_desktop/components/functions.dart';
//import 'package:jappeos_desktop/windowManager/wmcontroller.dart';
import 'desktop.dart';
//import 'displayManager/josdm.dart';
//import 'applications/settings.dart';
//import 'applications/settings/settings-redesign.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(JappeOsDesktop());
}

class JappeOsDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jappeos_desktop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: DesktopCfg.DESKTOPCFG_INSTANCE.getJappeosThemeColor(JappeOsColor.DEFAULT)),
      ),
      home: Desktop(title: 'JappeOS'),
    );
  }
}