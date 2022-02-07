// ignore_for_file: invalid_annotation_target

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../consts.dart';
//import 'package:simpa_desktop/components/consts.dart';

// DESKTOP DIALOG

/*class Dialog extends StatefulWidget {
  final Widget child;

  Dialog({Key key, @required this.child}) : super(key: key);

  _DialogState createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 0,
              top: 30,
              bottom: 0,
              right: 0,
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.black45.withOpacity(0.7),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.white30,
                      spreadRadius: 1,
                    )
                  ]),
              alignment: Alignment.topRight,
              height: 500,
              width: 300,

              // content
              child: Container(
                child: widget.child,
              ),
            ),
          )
        ],
      )
    ]);
  }
}*/

// JAPPEOS SETTINGS SIDEBAR BUTTON

class SettingsSidebarButton extends StatefulWidget {
  final IconData jicon;
  final String jtext;
  final double jstartopacity;
  final Color jhighlight;

  SettingsSidebarButton({Key key, @required this.jicon, @required this.jtext, @required this.jstartopacity, @required this.jhighlight})
      : super(key: key);

  _SettingsSidebarButtonState createState() => _SettingsSidebarButtonState();
}

class _SettingsSidebarButtonState extends State<SettingsSidebarButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 1,
          decoration: BoxDecoration(
            color: dsktp_ACCENT_COLOR.withOpacity(widget.jstartopacity),
          ),
        ),
        Container(
          height: 43,
          width: 1,
          decoration: BoxDecoration(
            color: dsktp_ACCENT_COLOR.withOpacity(widget.jstartopacity),
          ),
        ),
        Container(
          height: 45,
          width: 300,
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 2.5,
            top: 2.5,
          ),
          child: FlatButton(
            hoverColor: Colors.black.withOpacity(0.2),
            child: Row(
              children: [
                Icon(
                  widget.jicon,
                  color: widget.jhighlight,
                ),
                Container(
                  width: 10,
                ),
                Text(
                  widget.jtext,
                  style: TextStyle(
                    color: widget.jhighlight,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

// JAPPEOS SETTINGS PAGE

// coming soon...

// JAPPEOS LAUNCHER ITEM BUTTON

class LauncherItemButton extends StatefulWidget {
  final String jicon;
  final String jtext;

  LauncherItemButton({Key key, @required this.jicon, @required this.jtext})
      : super(key: key);

  _LauncherItemButtonState createState() => _LauncherItemButtonState();
}

class _LauncherItemButtonState extends State<LauncherItemButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 110,
      child: FlatButton(
        child: Column(
          children: [
            Container(
              width: 100,
              height: 90,
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.jicon), // icon file
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 100,
              height: 20,
              padding: EdgeInsets.only(
                left: 1,
                right: 1,
                bottom: 1,
              ),
              child: Text(
                widget.jtext, // source label
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
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
        onPressed: () {},
      ),
    );
  }
}

// JAPPEOS APPBAR

class Jappbar extends StatefulWidget {
  final Widget jleft;
  final Widget jcenter;
  final Widget jright;

  Jappbar(
      {Key key,
      @optionalTypeArgs this.jleft,
      @optionalTypeArgs this.jcenter,
      @optionalTypeArgs this.jright})
      : super(key: key);

  _JappbarState createState() => _JappbarState();
}

class _JappbarState extends State<Jappbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      //color: Colors.black87,
      child: Stack(
        children: [
          Positioned(
            left: 10,
            width: 310,
            top: 5,
            bottom: 5,
            child: widget.jleft,
          ),
          Center(
            child: Container(
              width: 300,
              height: 45,
              child: widget.jcenter,
            ),
          ),
          Positioned(
            right: 10,
            width: 500,
            top: 5,
            bottom: 5,
            child: widget.jright,
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        /*boxShadow: [
          BoxShadow(
            color: Color(0xFF212121),
            blurRadius: 4,
            offset: Offset(0, 5),
          ),
        ],*/
      ),
    );
  }
}

// JAPPEOS APP-MAIN-SEARCH-BAR

class JAppMainSearchBox extends StatefulWidget {
  final String jbgtext;

  JAppMainSearchBox({Key key, @optionalTypeArgs this.jbgtext})
      : super(key: key);

  _JAppMainSearchBoxState createState() => _JAppMainSearchBoxState();
}

class _JAppMainSearchBoxState extends State<JAppMainSearchBox> {
  final TextEditingController _controller = TextEditingController();

  void _clearTextField() {
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      height: 30,
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          setState(() {});
        },
        autofocus: true,
        style: TextStyle(color: Colors.white),
        inputFormatters: [
          LengthLimitingTextInputFormatter(24),
        ],
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10),
          filled: true,
          counterText: "",
          hintStyle: TextStyle(color: Colors.white70),
          hintText: widget.jbgtext,
          hoverColor: Colors.black.withOpacity(0.1),
          fillColor: Colors.black.withOpacity(0.1),
          prefixIcon: Icon(
            Icons.search_sharp,
            color: Colors.white70,
          ),
          suffixIcon: _controller.text.length == 0
              ? null // Show nothing if the text field is empty
              : IconButton(
                  icon: Icon(
                    Icons.clear_sharp,
                    color: Colors.white70,
                  ),
                  onPressed: _clearTextField,
                ),
          enabledBorder: new OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white24,
              ),
              borderRadius: BorderRadius.circular(30)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white54, width: 1),
              borderRadius: BorderRadius.circular(30)),
        ),
      ),
      /*decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        //color: Colors.red,
      ),*/
    );
  }
}

// JAPPEOS SETTINGS-TILE

class JSettingsTile extends StatefulWidget {
  final Widget jitems;
  final double jheight;

  JSettingsTile({Key key, @required this.jitems, @optionalTypeArgs this.jheight})
      : super(key: key);

  _JSettingsTileState createState() => _JSettingsTileState();
}

class _JSettingsTileState extends State<JSettingsTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.jheight,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
        //border: Border.all(
          //color: Colors.black.withOpacity(0.35),
          //width: 1,
        //),
        color: Colors.black.withOpacity(0.3),
      ),
      child: widget.jitems,
    );
  }
}

// JAPPEOS SETTINGS-TILE-TITLE

class JSettingsTileTitle extends StatefulWidget {
  final String jtitle;
  final Widget jenditem;

  JSettingsTileTitle({Key key, @required this.jtitle, @required this.jenditem})
      : super(key: key);

  _JSettingsTileTitleState createState() => _JSettingsTileTitleState();
}

class _JSettingsTileTitleState extends State<JSettingsTileTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50, // height: widget.jheight,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),),
        //border: Border.all(
          //color: Colors.black.withOpacity(0.35),
          //width: 1,
        //),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            height: 30,
            width: 200,
            child: widget.jenditem,
          ),
          Positioned(
            left: 0,
            top: 0,
            height: 30,
            width: 500,
            child: Text(
              widget.jtitle,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}