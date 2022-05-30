import 'package:flutter/material.dart';
//import 'package:jappeos_desktop/components/functions.dart';
//import 'package:jappeos_desktop/windowManager/wmcontroller.dart';
import 'components/consts.dart';
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
        visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: dsktp_ACCENT_COLOR),
      ),
      home: Desktop(title: 'JappeOS'),
    );
  }
}