// import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simpa_desktop/components/consts.dart';
import 'package:simpa_desktop/components/cwidgets.dart';

void main() {
  runApp(SimpaDesktop());
}

class SimpaDesktop extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Desktop',
    home: Desktop(title: ''),
    debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
    );
  }
}


// DESKTOP PAGE
class Desktop extends StatefulWidget {
  Desktop({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyDesktopPageState createState() => _MyDesktopPageState();
}


class _MyDesktopPageState extends State<Desktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(dsktpWallpaper), // desktop background image
            fit: BoxFit.cover,
          ),
        ),
        
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned( // Desktop icons
                      top: 30,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              RaisedButton( // button to test the window manager
                                onPressed: () {},
                                child: Text('open an empty window!',
                                style: TextStyle(fontSize: 20,)),
                                color: Colors.blue,
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              RaisedButton( // button to restart the os on linux
                                onPressed: () {
                                  //Process.run('reboot', [' ']);
                                },
                                child: Text('Reboot linux',
                                style: TextStyle(fontSize: 20,)),
                                color: Colors.red,
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                          Row(

                          ),
                          Row(

                          ),
                          Row(

                          ),
                          Row(

                          ),
                          Row(

                          ),
                          Row(

                          ),
                          Row(

                          ),
                          Row(

                          ),
                          Row(

                          ),
                          Row(

                          ),
                          Row(

                          ),
                          Row(

                          ),
                          Row(

                          ),
                        ],
                      ),
                    ),
                    Container( // Window moving area & other things on top of windows
                      child: Stack(
                        children: <Widget>[
                          Stack( // Window moving area
                            children: <Widget>[
                              
                            ],
                          ),
                          
                          Positioned( // Bottom dock
                            bottom: 0,
                            left: 200,
                            right: 200,
                        
                            height: 100,

                            child: Container(
                              child: dockContainer(
                                Container(
                                  child: Positioned(
                                    left: 0,
                                    child: Stack(
                                      children: <Widget>[
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              ), 
                            ),
                          ),
                          Positioned( // Top bar
                            top: 0,
                            left: 0,
                            right: 0,
                            height: 30,
                            
                            child: Container(
                              child: topBarContainer(
                                Stack(
                                  children: <Widget>[
                                    Positioned( // top bar left side
                                      left: 0,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 30,
                                            child: FlatButton(
                                              padding: EdgeInsets.all(0),
                                              child: Icon(Icons.apps, color: Colors.white.withOpacity(0.8)),
                                              onPressed: () {
                                                Navigator.push(context,
                                                MaterialPageRoute(builder: (context)=>Launcher()));
                                              },
                                            ),
                                          ),
                                          Container(width: 10,),
                                          Text(
                                            'Desktop-1',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                          Container(
                                            width: 25,
                                            child: FlatButton(
                                              padding: EdgeInsets.all(0),
                                              child: Icon(Icons.arrow_drop_down_circle, color: Colors.white.withOpacity(0.8)),
                                              onPressed: () {
                                                showDialog(
                                                  barrierColor: Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return Stack(
                                                      alignment: Alignment.topLeft,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 0, top: 30, bottom: 0, right: 0,),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                                                              color: Colors.black45.withOpacity(0.7),
                                                              boxShadow: [
                                                                BoxShadow(offset: Offset(0, 1), color: Colors.white30, spreadRadius: 1,)
                                                              ]
                                                            ),
                                                            alignment: Alignment.topRight,
                                                            height: 500,
                                                            width: 300,
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Container( // Header I
                                                                    height: 40,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'Select your desktop',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 25,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Header II
                                                                    height: 23,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'Select one from the list below.',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white.withOpacity(0.7),
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Body
                                                                    height: 360,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10, right: 35,),
                                                                    // color: Colors.green,
                                                                    child: Text(
                                                                      'Dialog content coming soon',
                                                                      textAlign: TextAlign.right,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Actions
                                                                    height: 50,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(right: 35,),
                                                                    
                                                                    child: Row(
                                                                      children: [
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'Action1'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                        Container(width: 10,),
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'Action2'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }
                                                );
                                              },
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Positioned( // top bar right side
                                      right: 0,
                                      child: Row(
                                        children: <Widget>[

                                          Container( // more items
                                            width: 30,
                                            child: FlatButton(
                                              padding: EdgeInsets.all(0),
                                              child: Icon(Icons.list, color: Colors.white.withOpacity(0.8)),
                                              onPressed: () {
                                                showDialog(
                                                  barrierColor: Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return Stack(
                                                      alignment: Alignment.topRight,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 0, top: 30, bottom: 0, right: 0,),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                                                              color: Colors.black45.withOpacity(0.7),
                                                              boxShadow: [
                                                                BoxShadow(offset: Offset(0, 1), color: Colors.white30, spreadRadius: 1,)
                                                              ]
                                                            ),
                                                            alignment: Alignment.topRight,
                                                            height: 500,
                                                            width: 300,
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Container( // Header I
                                                                    height: 40,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'More items',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 25,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Header II
                                                                    height: 23,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'The rest of the items.',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white.withOpacity(0.7),
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Body
                                                                    height: 360,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10, right: 35,),
                                                                    // color: Colors.green,
                                                                    child: Text(
                                                                      'Dialog content coming soon',
                                                                      textAlign: TextAlign.right,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Actions
                                                                    height: 50,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(right: 35,),
                                                                    
                                                                    child: Row(
                                                                      children: [
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'Action1'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                        Container(width: 10,),
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'Action2'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }
                                                );
                                              },
                                            ),
                                          ),

                                          Container(width: 10,), // Adds a small space between buttons

                                          Container( // wifi status
                                            width: 30,
                                            child: FlatButton(
                                              padding: EdgeInsets.all(0),
                                              child: Icon(Icons.wifi, color: Colors.white.withOpacity(0.8)),
                                              onPressed: () {
                                                showDialog(
                                                  barrierColor: Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return Stack(
                                                      alignment: Alignment.topRight,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 0, top: 30, bottom: 0, right: 0,),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                                                              color: Colors.black45.withOpacity(0.7),
                                                              boxShadow: [
                                                                BoxShadow(offset: Offset(0, 1), color: Colors.white30, spreadRadius: 1,)
                                                              ]
                                                            ),
                                                            alignment: Alignment.topRight,
                                                            height: 500,
                                                            width: 300,
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Container( // Header I
                                                                    height: 40,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'Wifi',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 25,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Header II
                                                                    height: 23,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'Connect the device to the internet.',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white.withOpacity(0.7),
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Body
                                                                    height: 360,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10, right: 35,),
                                                                    // color: Colors.green,
                                                                    child: Text(
                                                                      'Dialog content coming soon',
                                                                      textAlign: TextAlign.right,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Actions
                                                                    height: 50,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(right: 35,),
                                                                    
                                                                    child: Row(
                                                                      children: [
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'Action1'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                        Container(width: 10,),
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'Action2'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }
                                                );
                                              },
                                            ),
                                          ),

                                          Container( // volume status
                                            width: 30,
                                            child: FlatButton(
                                              padding: EdgeInsets.all(0),
                                              child: Icon(Icons.volume_up, color: Colors.white.withOpacity(0.8)),
                                              onPressed: () {
                                                showDialog(
                                                  barrierColor: Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return Stack(
                                                      alignment: Alignment.topRight,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 0, top: 30, bottom: 0, right: 0,),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                                                              color: Colors.black45.withOpacity(0.7),
                                                              boxShadow: [
                                                                BoxShadow(offset: Offset(0, 1), color: Colors.white30, spreadRadius: 1,)
                                                              ]
                                                            ),
                                                            alignment: Alignment.topRight,
                                                            height: 500,
                                                            width: 300,
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Container( // Header I
                                                                    height: 40,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'Sounds',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 25,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Header II
                                                                    height: 23,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'Change your volume or the device.',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white.withOpacity(0.7),
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Body
                                                                    height: 360,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10, right: 35,),
                                                                    // color: Colors.green,
                                                                    child: Text(
                                                                      'Dialog content coming soon',
                                                                      textAlign: TextAlign.right,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Actions
                                                                    height: 50,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(right: 35,),
                                                                    
                                                                    child: Row(
                                                                      children: [
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'Action1'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                        Container(width: 10,),
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'Action2'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }
                                                );
                                              },
                                            ),
                                          ),

                                          Container( // battery status
                                            width: 30,
                                            child: FlatButton(
                                              padding: EdgeInsets.all(0),
                                              child: Icon(Icons.battery_unknown, color: Colors.white.withOpacity(0.8)),
                                              onPressed: () {
                                                showDialog(
                                                  barrierColor: Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return Stack(
                                                      alignment: Alignment.topRight,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 0, top: 30, bottom: 0, right: 0,),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                                                              color: Colors.black45.withOpacity(0.7),
                                                              boxShadow: [
                                                                BoxShadow(offset: Offset(0, 1), color: Colors.white30, spreadRadius: 1,)
                                                              ]
                                                            ),
                                                            alignment: Alignment.topRight,
                                                            height: 500,
                                                            width: 300,
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Container( // Header I
                                                                    height: 40,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'Battery',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 25,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Header II
                                                                    height: 23,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'Status: unknown',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white.withOpacity(0.7),
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Body
                                                                    height: 360,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10, right: 35,),
                                                                    // color: Colors.green,
                                                                    child: Text(
                                                                      'Dialog content coming soon',
                                                                      textAlign: TextAlign.right,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Actions
                                                                    height: 50,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(right: 35,),
                                                                    
                                                                    child: Row(
                                                                      children: [
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'Action1'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                        Container(width: 10,),
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'Action2'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }
                                                );
                                              },
                                            ),
                                          ),

                                          Container( // keyboard layout
                                            width: 30,
                                            child: FlatButton(
                                              padding: EdgeInsets.all(0),
                                              child: Icon(Icons.keyboard, color: Colors.white.withOpacity(0.8)),
                                              onPressed: () {
                                                showDialog(
                                                  barrierColor: Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return Stack(
                                                      alignment: Alignment.topRight,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 0, top: 30, bottom: 0, right: 0,),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                                                              color: Colors.black45.withOpacity(0.7),
                                                              boxShadow: [
                                                                BoxShadow(offset: Offset(0, 1), color: Colors.white30, spreadRadius: 1,)
                                                              ]
                                                            ),
                                                            alignment: Alignment.topRight,
                                                            height: 500,
                                                            width: 300,
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Container( // Header I
                                                                    height: 40,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'Keyboard layout',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 25,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Header II
                                                                    height: 23,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'Select your keyboard layout.',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white.withOpacity(0.7),
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Body
                                                                    height: 360,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10, right: 35,),
                                                                    // color: Colors.green,
                                                                    child: Drawer(
                                                                      /*child: ListView(
                                                                        children: <Widget>[
                                                                          ListTile(
                                                                            leading: Icon(Icons.keyboard, color: Colors.white54,),
                                                                            title: Text('Item'),
                                                                          ),
                                                                        ],
                                                                      ),*/
                                                                    ),
                                                                  ),
                                                                  Container( // Actions
                                                                    height: 50,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(right: 35,),
                                                                    
                                                                    child: Row(
                                                                      children: [
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'More'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                        Container(width: 10,),
                                                                        Container(
                                                                          width: 35,
                                                                          child: RaisedButton(
                                                                            padding: EdgeInsets.all(0),
                                                                            child: Icon(
                                                                              Icons.add
                                                                            ),
                                                                            color: Colors.blue,
                                                                            onPressed: () {
                                                                            
                                                                            }
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: 35,
                                                                          child: RaisedButton(
                                                                            padding: EdgeInsets.all(0),
                                                                            child: Icon(
                                                                              Icons.remove
                                                                            ),
                                                                            color: Colors.red,
                                                                            onPressed: () {
                                                                            
                                                                            }
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }
                                                );
                                              },
                                            ),
                                          ),
                                          
                                          Container( // time
                                            width: 50,
                                            child: FlatButton(
                                              padding: EdgeInsets.all(0),
                                              child: Text(
                                                '19:40',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white.withOpacity(0.8),
                                                ),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                  barrierColor: Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return Stack(
                                                      alignment: Alignment.topRight,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 0, top: 30, bottom: 0, right: 0,),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                                                              color: Colors.black45.withOpacity(0.7),
                                                              boxShadow: [
                                                                BoxShadow(offset: Offset(0, 1), color: Colors.white30, spreadRadius: 1,)
                                                              ]
                                                            ),
                                                            alignment: Alignment.topRight,
                                                            height: 500,
                                                            width: 300,
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Container( // Header I
                                                                    height: 40,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      'Date & time',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 25,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Header II
                                                                    height: 23,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10,),
                                                                    child: Text(
                                                                      '--/--/---- • --.--',
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Colors.white.withOpacity(0.7),
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Body
                                                                    height: 360,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(top: 10, right: 35,),
                                                                    // color: Colors.green,
                                                                    child: Text(
                                                                      'Dialog content coming soon',
                                                                      textAlign: TextAlign.right,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 14,
                                                                        decoration: TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container( // Actions
                                                                    height: 50,
                                                                    width: 270,
                                                                    padding: EdgeInsets.only(right: 35,),
                                                                    
                                                                    child: Row(
                                                                      children: [
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'Action1'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                        Container(width: 10,),
                                                                        RaisedButton(
                                                                          child: Text(
                                                                            'Action2'
                                                                          ),
                                                                          onPressed: () {
                                                                            
                                                                          }
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ), 
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Blur effects
  Widget topBarContainer (Widget child) {
    return ClipRRect (
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          height: MediaQuery
            .of(context)
            .size
            .height / 4,
          width: MediaQuery
            .of(context)
            .size
            .width / 1.2,
          color: dsktpBlurKey,
          child: child,
        ),
      ),
    );
  }

  Widget dockContainer (Widget child) {
    return ClipRRect (
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          height: MediaQuery
            .of(context)
            .size
            .height / 4,
          width: MediaQuery
            .of(context)
            .size
            .width / 1.2,
          color:Colors.black.withOpacity(0.6),
          child: child,
        ),
      ),
    );
  }

}


// LAUNCHER PAGE
class Launcher extends StatefulWidget {
  Launcher({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyLauncherPageState createState() => _MyLauncherPageState();
}



class _MyLauncherPageState extends State<Launcher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(dsktpWallpaper), // desktop background image
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            // Topbar
            Positioned(
              top: -5,
              left: 0,
              right: 0,
              height: 35,
              child: Container(
                child: topBarContainer(           
                  Stack(
                    children: <Widget>[
                      // Topbar left side
                      Positioned(
                        //top: 10,
                        left: 0,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.apps, color: Colors.white,),
                              tooltip: 'Escape',
                              onPressed: () {
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>Desktop()));
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2, /*left: 5, right: 5,*/),
                              width: 2,
                              height: 20,
                              color: Colors.white38,
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white,),
                              tooltip: 'Edit',
                              onPressed: () {

                              },
                            ),
                          /*onPressed: () {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>Desktop()));
                          },*/
                          ],
                        ),
                      ),

                      // Topbar center
                      Center(
                        child: Container(
                          height: 35,
                          width: 200,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              '7.35PM',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: ( () {}

                            ),
                          ),
                        ),
                      ),

                      // Topbar right side
                      Positioned(
                        //top: 10,
                        right: 0,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.notifications, color: Colors.white,),
                              tooltip: 'Notifications',
                              onPressed: () {

                              },
                            ),
                          /*onPressed: () {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>Desktop()));
                          },*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Launcher content
            Positioned(
              top: 30,
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                child: contentContainer(
                  Stack(
                    children: <Widget>[
                      
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: EdgeInsets.only(top: 40,),
                          height: double.infinity,
                          width: 675,
                          //color: Colors.red,
                          child: ListView(
                            children: [
                              Wrap(
                            direction: Axis.horizontal,
                            spacing: 15,
                            runSpacing: 15,
                            children: [

                              LauncherItemButton(
                                jicon: dsktpWallpaper,
                                jtext: '76d212f4-c10c-4ba3-b571-84b50b203afe',
                              ),

                              Container(
                                width: 100,
                                height: 110,
                                child: FlatButton(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 90,
                                        padding: EdgeInsets.only(left: 5, right: 5,),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(dsktpWallpaper), // desktop background image
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 20,
                                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 3,),
                                        child: Text(
                                          'ItemTitle',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(color: Colors.red)
                                  ),
                                  hoverColor: Colors.black.withOpacity(0.2),
                                  onPressed: () {

                                  },
                                ),
                                
                              ),


                              Container(
                                width: 100,
                                height: 110,
                                child: FlatButton(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 90,
                                        padding: EdgeInsets.only(left: 5, right: 5,),
                                        child: Icon(Icons.settings, color: Colors.white, size: 50,),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 20,
                                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 3,),
                                        child: Text(
                                          'ItemTitle',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(color: Colors.red)
                                  ),
                                  hoverColor: Colors.black.withOpacity(0.2),
                                  onPressed: () {

                                  },
                                ),
                                
                              ),
                              Container(
                                width: 100,
                                height: 110,
                                child: FlatButton(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 90,
                                        padding: EdgeInsets.only(left: 5, right: 5,),
                                        child: Icon(Icons.settings, color: Colors.white, size: 50,),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 20,
                                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 3,),
                                        child: Text(
                                          'ItemTitle',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(color: Colors.red)
                                  ),
                                  hoverColor: Colors.black.withOpacity(0.2),
                                  onPressed: () {

                                  },
                                ),
                                
                              ),
                              Container(
                                width: 100,
                                height: 110,
                                child: FlatButton(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 90,
                                        padding: EdgeInsets.only(left: 5, right: 5,),
                                        child: Icon(Icons.settings, color: Colors.white, size: 50,),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 20,
                                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 3,),
                                        child: Text(
                                          'ItemTitle',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(color: Colors.red)
                                  ),
                                  hoverColor: Colors.black.withOpacity(0.2),
                                  onPressed: () {

                                  },
                                ),
                                
                              ),
                              Container(
                                width: 100,
                                height: 110,
                                child: FlatButton(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 90,
                                        padding: EdgeInsets.only(left: 5, right: 5,),
                                        child: Icon(Icons.settings, color: Colors.white, size: 50,),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 20,
                                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 3,),
                                        child: Text(
                                          'ItemTitle',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(color: Colors.red)
                                  ),
                                  hoverColor: Colors.black.withOpacity(0.2),
                                  onPressed: () {

                                  },
                                ),
                                
                              ),


                            ],
                          ),
                            ],
                          ),
                        ),
                      ),

                      /*Align(
                        alignment: Alignment.topCenter,
                          
                        child: Container( // action buttons
                          width: 475,
                          child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 15,
                            children: [
                              Container(
                                width: 55,
                                height: 70,
                                padding: EdgeInsets.only(top: 15,),
                                child: RaisedButton(
                                  onPressed: () {

                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Icon(Icons.power_settings_new, color: Colors.white, size: 50,),
                                  color: Colors.blue.withOpacity(0.6),
                                ),
                              ),
                              Container(
                                width: 55,
                                height: 70,
                                padding: EdgeInsets.only(top: 15,),
                                child: RaisedButton(
                                  onPressed: () {

                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Icon(Icons.update, color: Colors.white, size: 50,),
                                  color: Colors.amber[800].withOpacity(0.6),
                                ),
                              ),
                              Container(
                                width: 55,
                                height: 70,
                                padding: EdgeInsets.only(top: 15,),
                                child: RaisedButton(
                                  onPressed: () {

                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Icon(Icons.settings, color: Colors.white, size: 50,),
                                  color: Colors.blue.withOpacity(0.6),
                                ),
                              ),
                              Container(
                                width: 55,
                                height: 70,
                                padding: EdgeInsets.only(top: 15,),
                                child: RaisedButton(
                                  onPressed: () {

                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Icon(Icons.wifi, color: Colors.white, size: 50,),
                                  color: Colors.blue.withOpacity(0.6),
                                ),
                              ),
                              Container(
                                width: 55,
                                height: 70,
                                padding: EdgeInsets.only(top: 15,),
                                child: RaisedButton(
                                  onPressed: () {

                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Icon(Icons.volume_off, color: Colors.white, size: 50,),
                                  color: Colors.blue.withOpacity(0.6),
                                ),
                              ),
                              Container(
                                width: 55,
                                height: 70,
                                padding: EdgeInsets.only(top: 15,),
                                child: RaisedButton(
                                  onPressed: () {

                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Icon(Icons.bluetooth_disabled, color: Colors.white, size: 50,),
                                  color: Colors.blue.withOpacity(0.6),
                                ),
                              ),
                              Container(
                                width: 55,
                                height: 70,
                                padding: EdgeInsets.only(top: 15,),
                                child: RaisedButton(
                                  onPressed: () {

                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Icon(Icons.airplanemode_inactive, color: Colors.white, size: 50,),
                                  color: Colors.blue.withOpacity(0.6),
                                ),
                              ),
                              Container(
                                width: 55,
                                height: 70,
                                padding: EdgeInsets.only(top: 15,),
                                child: RaisedButton(
                                  onPressed: () {

                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Icon(Icons.battery_unknown, color: Colors.white, size: 50,),
                                  color: Colors.blue.withOpacity(0.6),
                                ),
                              ),
                              Container(
                                width: 55,
                                height: 70,
                                padding: EdgeInsets.only(top: 15,),
                                child: RaisedButton(
                                  onPressed: () {

                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Icon(Icons.location_off, color: Colors.white, size: 50,),
                                  color: Colors.blue.withOpacity(0.6),
                                ),
                              ),
                              Container(
                                width: 55,
                                height: 70,
                                padding: EdgeInsets.only(top: 15,),
                                child: RaisedButton(
                                  onPressed: () {

                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Icon(Icons.do_not_disturb_off, color: Colors.white, size: 50,),
                                  color: Colors.blue.withOpacity(0.6),
                                ),
                              ),
                              Container(
                                width: 55,
                                height: 70,
                                padding: EdgeInsets.only(top: 15,),
                                child: RaisedButton(
                                  onPressed: () {

                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Icon(Icons.brightness_7, color: Colors.white, size: 50,),
                                  color: Colors.blue.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Blur effects
  Widget topBarContainer (Widget child) {
    return ClipRRect (
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
        child: Container(
          height: MediaQuery
            .of(context)
            .size
            .height / 4,
          width: MediaQuery
            .of(context)
            .size
            .width / 1.2,
          color: dsktpDesktopDsktpBlurColor.withOpacity(0.6),
          child: child,
        ),
      ),
    );
  }
  Widget contentContainer (Widget child) {
    return ClipRRect (
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          height: MediaQuery
            .of(context)
            .size
            .height / 4,
          width: MediaQuery
            .of(context)
            .size
            .width / 1.2,
          color:Colors.black.withOpacity(0.5),
          child: child,
        ),
      ),
    );
  }
}


class Notifications extends StatefulWidget {
  Notifications({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyNotificationsPageState createState() => _MyNotificationsPageState();
}



class _MyNotificationsPageState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(dsktpWallpaper), // desktop background image
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            // Topbar
            Positioned(
              top: -5,
              left: 0,
              right: 0,
              height: 35,
              child: Container(
                child: topBarContainer(           
                  Stack(
                    children: <Widget>[
                      // Topbar right side
                      Positioned(
                        right: 0,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            'Close',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>Desktop()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Notifications content
            Positioned(
              top: 30,
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                child: contentContainer(
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                          
                        child: Container(
                          width: 240,
                          child: Row(
                            children: [
                              FlatButton(
                                padding: EdgeInsets.all(0),
                                child: Row(
                                  children: [
                                    Icon(Icons.apps, color: Colors.white,),
                                    Text(
                                      'App launcher',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>Launcher()));
                                },
                          
                              ),
                              Container(width: 10, height: 10,),
                              Column(
                                children: [
                                  FlatButton(
                                    padding: EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.notifications_active, color: Colors.blue[300],),
                                        Text(
                                          'Notifications',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[300],
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                
                                    },
                          
                                  ),
                                  Container(
                                    height: 3,
                                    width: 120,
                                    color: Colors.blue[300],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                        ),
                      ),

                      Align(
                        alignment: Alignment.topCenter,
                          
                        child: Container(
                          width: 400,
                          child: Column(
                            children: [ // Notifications
                              
                            ],
                          ),
                          
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Blur effects (NOTE: not for topbar)
  Widget topBarContainer (Widget child) {
    return ClipRRect (
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          height: MediaQuery
            .of(context)
            .size
            .height / 4,
          width: MediaQuery
            .of(context)
            .size
            .width / 1.2,
          color: dsktpBlurKey,
          child: child,
        ),
      ),
    );
  }
  Widget contentContainer (Widget child) {
    return ClipRRect (
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          height: MediaQuery
            .of(context)
            .size
            .height / 4,
          width: MediaQuery
            .of(context)
            .size
            .width / 1.2,
          color:Colors.black.withOpacity(0.2),
          child: child,
        ),
      ),
    );
  }
}