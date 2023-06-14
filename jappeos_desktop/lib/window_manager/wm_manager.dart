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

// ignore_for_file: library_private_types_in_public_api

part of window_manager;

/// A widget to manage windows.
class WmManager extends StatefulWidget {
  final WmController? wmController;

  const WmManager({Key? key, this.wmController}) : super(key: key);

  @override
  _WmManagerState createState() => _WmManagerState();
}

class _WmManagerState extends State<WmManager> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: widget.wmController!.windows.map((e) {
      return Positioned(
        left: !MOBILE_MODE ? e.getPos().dx : 0,
        top: !MOBILE_MODE ? e.getPos().dy : DSKTP_UI_LAYER_TOPBAR_HEIGHT,
        key: e.key,
        child: e,
      );
    }).toList());
  }
}
