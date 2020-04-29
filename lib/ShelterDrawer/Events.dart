import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:share/share.dart';


Color mainColor = Colors.blue;

//comitted//
class Events extends StatefulWidget{
  @override
  EventsState createState() => EventsState();
}

class EventsState extends State<Events> {

  @override
  void initState() {
    super.initState();
    Timer.run(() => _showDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 20.0,
          color: mainColor,
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,

                      image: AssetImage('assets/shelter.jpg'),
                    )
                ),
              )
          ),

          Container(
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                    alignment: Alignment.topCenter,
                    child: FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      shape:
                      RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      padding: EdgeInsets.only(
                          top: 10, left: 10.0, right: 10.0, bottom: 10),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        _showDialogVolunteer();
                      },
                      child: Text(
                        "Schedule Volunteer Event",
                        style: TextStyle(fontSize: 20.0),

                      ),
                    )
                )
              ],


            ),

          ),

          Container(
              margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
              alignment: Alignment.topCenter,
              child: FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                shape:
                RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                padding: EdgeInsets.only(
                    top: 10, left: 80.0, right: 80.0, bottom: 10),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  _showDialogFundraising();
                },
                child: Text(
                  "Fundraising",
                  style: TextStyle(fontSize: 20.0),

                ),
              )
          )
        ],

      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text(" Events "),
          content: new Text("Coming Soon...."),
          actions: <Widget>[
            new FlatButton(
              child: new
              Text("Sounds good ?"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogVolunteer() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text(" Schedule for Volunteer "),
          content: new Text("Coming Soon...."),
          actions: <Widget>[
            new FlatButton(
              child: new
              Text("Sounds good ?"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogFundraising() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text(" Fundraising "),
          content: new Text("Coming Soon...."),
          actions: <Widget>[
            new FlatButton(
              child: new
              Text("Sounds good ?"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
