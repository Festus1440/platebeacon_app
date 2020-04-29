import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:custom_switch/custom_switch.dart';

Color mainColor = Colors.green;

// slide bar code
//
//----- Code comitted-----//
class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool status = false;
  bool emailStatus = false;
  bool msgStatus = false;
  bool callStatus = false;

  @override
  void initState() {
    super.initState();
    Timer.run(() => _showDialog());
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
        child: Container(
          height: 20.0,
          color: mainColor,
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              //alignment: Alignment.topLeft,
              child: Text(
                "Select which apps you want to receive notifications",
                style: TextStyle(
                  fontSize: 15.0,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
                margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 15.0),
                child: Row(children: [
                  const Icon(
                    Icons.email,
                    size: 50.0,
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
                      activeColor: Colors.greenAccent,
                      value: emailStatus,
                      onChanged: (value) {
                        print("VALUE : $value");
                        setState(() {
                          emailStatus = value;
                        });
                      })
                ])),
          ),
          Divider(
            height: 20.0,
            thickness: 0.5,
            color: mainColor,
            indent: 0.0,
            endIndent: 0.0,
          ),
          Container(
            //color: Colors.black12,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.only(top: 30.0, left: 30.0, right: 15.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Row(children: [
                              const Icon(Icons.message, size: 50.00),
                              Text(
                                "  Messages",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Switch(
                                  activeColor: Colors.greenAccent,
                                  value: msgStatus,
                                  onChanged: (value) {
                                    print("VALUE : $value");
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
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.only(top: 30.0, left: 30.0, right: 15.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Row(children: [
                              const Icon(
                                Icons.call,
                                size: 50.00,
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
                                    print("VALUE : $value");
                                    setState(() {
                                      callStatus = value;
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
                  ],
                ),
              ],
            ),
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
        elevation: 0.0,
        shape:
        RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
        backgroundColor:Colors.white,
        title: new Text("Notifications"),

        content: new Text("Coming Soon ....."),
        actions: <Widget>[
// usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Ok"),
            textColor: Colors.green,
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

