import 'package:flutter/material.dart';

class SetupPage extends StatefulWidget {
  SetupPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MySetupPageState createState() => _MySetupPageState();
}

class _MySetupPageState extends State<SetupPage> { // welcome page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, select your language'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 50,
              bottom: 50,
              left: 50,
              width: 400,
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: ListView(
                      children: <Widget>[ // language items
                        Container(
                          child: Ink(
                            color: Colors.blue,
                            child: ListTile(
                              title: Text('English'),
                              onTap: () {
                                
                              }
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
