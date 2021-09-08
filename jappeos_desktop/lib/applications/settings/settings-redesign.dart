import 'package:flutter/material.dart';
import 'package:jappeos_desktop/components/consts.dart';
import 'package:jappeos_desktop/components/cwidgets.dart';

/*void main() {
  runApp(MyApp());
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WiFiPage(title: 'JappeOS'), 
    );
  }
}*/

class WifiPage extends StatefulWidget {
  WifiPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WifiPageState createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(top: 55, left: 330,),
            color: Color(0xFF303030),
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [
                JSettingsTileTitle(
                  jtitle: 'Connect to wifi',
                  jenditem: Container(),
                ),
                JSettingsTile( // setting tile
                  //jheight: 100,
                  jitems: Column( // setting tile content
                    children: [
                      Container( 
                        height: 20,
                        child: Text('nothing here yet', style: TextStyle(color: Colors.red,),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Jappbar(
            jleft: JAppMainSearchBox(
              jbgtext: 'Search settings...',
            ),
            jright: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white70,),
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  right: 50,
                  child: IconButton(
                    icon: Icon(Icons.crop_square, color: Colors.white70,),
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  right: 100,
                  child: IconButton(
                    icon: Icon(Icons.minimize, color: Colors.white70,),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: 55,),
              padding: EdgeInsets.only(top: 10,),
              width: 330, // 300 + 10 + 10 + 10
              height: double.infinity,
              color: Colors.black87,
              child: ListView(
                children: [
                  SettingsSidebarButton(
                    jicon: Icons.wifi,
                    jtext: 'Wifi',
                    jstartopacity: 1,
                    jhighlight: dsktp_ACCENT_COLOR,
                  ),
                  SettingsSidebarButton(
                    jicon: Icons.bluetooth,
                    jtext: 'Bluetooth',
                    jstartopacity: 0,
                    jhighlight: dsktp_TEXT_COLOR,
                  ),
                  SettingsSidebarButton(
                    jicon: Icons.edit,
                    jtext: 'Appearance',
                    jstartopacity: 0,
                    jhighlight: dsktp_TEXT_COLOR,
                  ),
                  SettingsSidebarButton(
                    jicon: Icons.notifications,
                    jtext: 'Notifications',
                    jstartopacity: 0,
                    jhighlight: dsktp_TEXT_COLOR,
                  ),
                  SettingsSidebarButton(
                    jicon: Icons.system_update,
                    jtext: 'Updates',
                    jstartopacity: 0,
                    jhighlight: dsktp_TEXT_COLOR,
                  ),
                  SettingsSidebarButton(
                    jicon: Icons.language,
                    jtext: 'Regions & Language',
                    jstartopacity: 0,
                    jhighlight: dsktp_TEXT_COLOR,
                  ),
                  SettingsSidebarButton(
                    jicon: Icons.account_circle,
                    jtext: 'Accounts',
                    jstartopacity: 0,
                    jhighlight: dsktp_TEXT_COLOR,
                  ),
                  SettingsSidebarButton(
                    jicon: Icons.security,
                    jtext: 'Security',
                    jstartopacity: 0,
                    jhighlight: dsktp_TEXT_COLOR,
                  ),
                  SettingsSidebarButton(
                    jicon: Icons.surround_sound,
                    jtext: 'Sound',
                    jstartopacity: 0,
                    jhighlight: dsktp_TEXT_COLOR,
                  ),
                  SettingsSidebarButton(
                    jicon: Icons.power_settings_new,
                    jtext: 'Power',
                    jstartopacity: 0,
                    jhighlight: dsktp_TEXT_COLOR,
                  ),
                  SettingsSidebarButton(
                    jicon: Icons.info,
                    jtext: 'About',
                    jstartopacity: 0,
                    jhighlight: dsktp_TEXT_COLOR,
                  ),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
