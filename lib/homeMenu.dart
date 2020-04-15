import 'package:flutter/material.dart';
import 'main.dart';
// this file isn't being used
class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          //alignment: Alignment.center,
          child: Center(
            child: Text("Notifications"),
          ),
        ),
      ],
    );
  }
}
