import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pickup extends StatefulWidget {
  @override
  _PickupState createState() => _PickupState();
}

class _PickupState extends State<Pickup> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListTile(
        onTap: (){

        },
        leading: Container(
          width: 50,
          height: 50,
          child: Icon(Icons.calendar_today),
        ),
        title: Text("User has set a pickup"),
        subtitle: Text("Subtitle"),
      ),
    );
  }
}