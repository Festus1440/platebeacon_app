import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';

Color mainColor = Colors.blue;
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
                  Text(
                    "All Apps",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  CustomSwitch(
                    activeColor: Colors.pinkAccent,
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
                ])),
          ),
          Divider(
            height: 20.0,
            thickness: 0.5,
            color: mainColor,
            indent: 0.0,
            endIndent: 0.0,
          ),
          Center(
            child: Container(
                margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 15.0),
                child: Row(children: [
                  const Icon(
                    Icons.email,
                    size: 50.0,
                  ),
                  Spacer(),
                  Switch(
                      activeColor: Colors.pinkAccent,
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
                              Spacer(),
                              Switch(
                                  activeColor: Colors.pinkAccent,
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
                              Spacer(),
                              Switch(
                                  activeColor: Colors.pinkAccent,
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
}
