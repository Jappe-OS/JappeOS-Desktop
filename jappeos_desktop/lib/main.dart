import 'package:flutter/material.dart';
import 'components/consts.dart';
import 'desktop.dart';
//import 'displayManager/josdm.dart';
//import 'applications/settings.dart';
//import 'applications/settings/settings-redesign.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jappeos_desktop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: dsktp_ACCENT_COLOR,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Desktop(title: 'JappeOS'),
    );
  }
}