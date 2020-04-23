import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color mainColor = Colors.blue;

class ShelterSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 20.0,
          color: mainColor,
        ),
      ),
      appBar: AppBar(
        elevation: 10.0,
        title: Text("Settings"),
        backgroundColor: mainColor,
      ),
    );
  }
}