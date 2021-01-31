import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:custom_switch/custom_switch.dart';

// slide bar code
//committed code
class Notifications extends StatefulWidget {
  final String type;

  Notifications(this.type);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Color mainColor;


  bool status = false;
  bool emailStatus = false;
  bool msgStatus = false;
  bool callStatus = false;

  @override
  void initState() {
    super.initState();
    if(widget.type == "Shelter"){
      mainColor = Colors.blue;
    }
    else {
      mainColor = Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Notifications"),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: BottomAppBar(
        color: mainColor,
        child: Padding(
          padding: EdgeInsets.all(20),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15.0, left: 30.0, right: 15.0),
            //alignment: Alignment.topLeft,
            child: Text(
              "Select how you'd like to receive notifications from Plate Beacon",
              style: TextStyle(
                fontSize: 15.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 15.0),
              child: Row(children: [
                Text(
                  "All Apps",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Switch(
                  activeColor: Colors.blueAccent,
                  value: status,
                  onChanged: (value) {
                    print("VALUE : $value");
                    setState(() {
                      status = value;
                      if (value == true) {
                        emailStatus = true;
                        msgStatus = true;
                        callStatus = true;
                      } else {
                        emailStatus = false;
                        msgStatus = false;
                        callStatus = false;
                      }
                    });
                    print("EmailStatus : $emailStatus");
                  },
                ),
              ]),
          ),
          Divider(
            height: 20.0,
            thickness: 0.5,
            color: mainColor,
            indent: 0.0,
            endIndent: 0.0,
          ),
          Container(
              margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 15.0),
              child: Row(children: [
                const Icon(
                  Icons.email,
                  size: 40.0,
                ),
                Text(
                  "  Mail",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Switch(
                    activeColor: Colors.blueAccent,
                    value: emailStatus,
                    onChanged: (value) {
                      print("email : $value");
                      setState(() {
                        emailStatus = value;
                      });
                    })
              ])),
          Divider(
            height: 20.0,
            thickness: 0.5,
            color: mainColor,
            indent: 0.0,
            endIndent: 0.0,
          ),
          Container(
            margin:
            EdgeInsets.only(top: 30.0, left: 30.0, right: 15.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Row(children: [
                    const Icon(Icons.message, size: 40.0),
                    Text(
                      "  Messages",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Switch(
                        activeColor: Colors.blueAccent,
                        value: msgStatus,
                        onChanged: (value) {
                          print("msgs : $value");
                          setState(() {
                            msgStatus = value;
                          });
                        }),
                  ]),
                ),
              ],
            ),
          ),
          Divider(
            height: 20.0,
            thickness: 0.5,
            color: mainColor,
            indent: 0.0,
            endIndent: 0.0,
          ),
          Container(
            margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 15.0),
            child: Row(children: [
              const Icon(
                Icons.call,
                size: 40.0,
              ),
              Text(
                "  Calls",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Switch(
                  activeColor: Colors.blueAccent,
                  value: callStatus,
                  onChanged: (value) {
                    print("calls : $value");
                    setState(() {
                      callStatus = value;
                    });
                  }),
            ]),
          ),
          Divider(
            height: 20.0,
            thickness: 0.5,
            color: mainColor,
            indent: 0.0,
            endIndent: 0.0,
          ),
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
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text("Notifications coming soon!"),

          content: new Text("Eventually, you will be able to pick and choose the notification methods you like"
              " in order to recieve information from Plate Beacon!"),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Sounds good!"),
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



