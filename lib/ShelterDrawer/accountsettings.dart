import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Settings.dart';

Color mainColor = Colors.green;

class AccountSettingsDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountSettingsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Account Settings"),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 20.0, color: mainColor,
        ),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    child: Text("Change email", style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ),
                Divider(
                  height: 40.0,
                  thickness: 0.5,
                  color: mainColor,
                  indent: 0.0,
                  endIndent: 0.0,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15.0, left: 0.0, right: 15.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Delete Account",
                                style: TextStyle(fontSize: 20.0,
                                  fontWeight: FontWeight.bold,),
                            ),
                          ),
                          Divider(height: 20.0,
                            thickness: 0.5,
                            color: mainColor,
                            indent: 0.0,
                            endIndent: 0.0,
                          ),
                        ],
                      )
                    )
                  ],
                )
              ],
            ),
          )
        ],
        ),
      ),

    );
  }
}