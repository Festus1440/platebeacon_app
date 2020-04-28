import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:custom_switch/custom_switch.dart';

Color mainColor = Colors.green;

// slide bar code
//
//----- Code comitted-----//
class Subscriptions extends StatefulWidget {
  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  bool status = false;
  bool premiumStatus = false;

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
        title: Text("Subscriptions"),
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
          const SizedBox(height: 60),
          RaisedButton(
            onPressed: () {},
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF689F38),
                    Color(0xFF558B2F),
                    //Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child: const Text('Subscribe', style: TextStyle(fontSize: 20)),
            ),
          ),
          Center(
            child: Container(
                margin: EdgeInsets.only(top: 35.0, left: 15.0, right: 15.0),
                child: Column(children: [
                  const Text('Basic Membership',
                      //style: TextStyle(fontWeight: FontWeight.bold),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ])),
          ),
          Center(
            child: Container(
                margin: EdgeInsets.only(top: 35.0, left: 50.0, right: 35.0),
                child: Row(children: [
                  const Text('Premium',
                      //style: TextStyle(fontWeight: FontWeight.bold),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Switch(
                      activeColor: Colors.greenAccent,
                      value: premiumStatus,
                      onChanged: (value) {
                        print("VALUE : $value");
                        setState(() {
                          premiumStatus = value;
                        });
                      })
                ])),
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
          title: new Text("Alert Dialog title"),

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
