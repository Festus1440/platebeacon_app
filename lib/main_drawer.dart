import 'package:flutter/material.dart';

import 'main.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: FlatButton(
            //elevation: 0.0,
            color: Colors.black38,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            //padding: EdgeInsets.fromLTRB(30.0, 8.0, 20.0, 8.0),
            //splashColor: Colors.blueAccent,
            onPressed: () {
              //Navigator.of(context).pushReplacementNamed('/home');
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Text(
                "Create account",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MenuDrawer2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: FlatButton(
            //elevation: 0.0,
            color: Colors.black38,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            //padding: EdgeInsets.fromLTRB(30.0, 8.0, 20.0, 8.0),
            //splashColor: Colors.blueAccent,
            onPressed: () {
              //Navigator.of(context).pushReplacementNamed('/home');
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Text(
                "Create",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
