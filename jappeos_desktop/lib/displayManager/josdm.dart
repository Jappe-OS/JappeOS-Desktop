//  JappeOS-Desktop, The desktop environment for JappeOS.
//  Copyright (C) 2022  Jappe02
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Affero General Public License as
//  published by the Free Software Foundation, either version 3 of the
//  License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Affero General Public License for more details.
//
//  You should have received a copy of the GNU Affero General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.

// NOTE: the display manager ui (in this file) will be improved later! Because this doesn't look good YET.
// This file was made in 2020.

// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: const LoginPage(title: ''),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Image.asset(
              "resources/images/desktop/backgrounds/wallpaper1.jpg",
              fit: BoxFit.cover,
            ),
          ),

          // Top bar begins here
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 30,
            child: Container(
              child: topBarContainer(
                Positioned(
                  left: 0,
                  child: Stack(
                    children: <Widget>[
                      IconButton(
                        iconSize: 5.0,
                        icon: const Icon(Icons.power_settings_new),
                        tooltip: 'Shutdown',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Top bar ends here

          // User list begins here
          Positioned(
            top: 50,
            left: 50,
            bottom: 50,
            width: 500,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.black, spreadRadius: 3, blurRadius: 5),
                    ],
                  ),
                  child: ListTile(
                      hoverColor: Colors.black,
                      leading: const CircleAvatar(
                        backgroundColor: Colors.green,
                        backgroundImage: AssetImage('resources/images/applications/account/default_avatar.png'),
                      ),
                      title: const Text('JUser01'),
                      subtitle: const Text('defaultuser'),
                      onTap: () {}),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.black, spreadRadius: 3, blurRadius: 5),
                    ],
                  ),
                  child: ListTile(
                      hoverColor: Colors.black,
                      leading: const CircleAvatar(
                        backgroundColor: Colors.red,
                        backgroundImage: AssetImage('resources/images/applications/account/default_avatar.png'),
                      ),
                      title: const Text('Guest'),
                      subtitle: const Text('use as a guest'),
                      onTap: () {}),
                ),
                Container(
                  height: 10,
                ),
              ],
            ),
          ),
          // User list ends here

          // User login box begins here
          Positioned(
            top: 70,
            right: 50,
            bottom: 70,
            width: 500,
            child: Container(
              child: froastedContainer(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.green,
                      backgroundImage: AssetImage('resources/images/applications/account/default_avatar.png'),
                    ),
                    const Text(
                      'JUser01',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        // ignore: missing_return
                        validator: (String? value) {
                          if (value!.trim().isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Text(
                      'Hit [ENTER] to submit.',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // User login box ends here
        ],
      ),
    );
  }

  Widget froastedContainer(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 1.2,
          color: Colors.white.withOpacity(0.3),
          child: child,
        ),
      ),
    );
  }

  Widget topBarContainer(Widget child) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 1.2,
          color: Colors.black.withOpacity(0.5),
          child: child,
        ),
      ),
    );
  }
}
