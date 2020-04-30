import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:share/share.dart';


Color mainColor = Colors.green;
class Help extends StatefulWidget{
  @override
  HelpState createState() => HelpState();

}
class HelpState extends State<Help> {
Color mainColor;
  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        if (user.displayName == "Shelter") {
          mainColor = Colors.blue;
        } else {
          mainColor = Colors.green;
        }

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 20.0,
          color: mainColor,
        ),
      ),
      body: Column (
        children: <Widget>[
          Center(
              child: Container (
                width: 200,
                height: 200,
                decoration: BoxDecoration (
                    image: DecorationImage (
                      fit: BoxFit.cover,
                      image: AssetImage('assets/PB.jpg'),
                    )
                ),
              )
          ),

          Container(
              child: Column (
                children: <Widget>[
                  //Column(
                  //children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                    alignment: Alignment.topCenter,
                    child: Text(
                      "If you nedd any help please contact us: ",
                      style: TextStyle(
                        fontSize: 20.0,
                        // fontWeight:FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            //  ],

          ),

          // ),

          ListTile(
            onTap: (){
              print("press");
            },
            contentPadding: EdgeInsets.only(top: 50, left: 30, right: 20),
            leading: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration (
                image: DecorationImage (
                  fit: BoxFit.cover,
                  image: AssetImage('assets/email.jpg'),
                ),
              ),
            ),
            title: Text("Email: platebeacon@gmail.com"),

          ),


          ListTile(
            onTap: (){
              print("press to instagram");
            },
            contentPadding: EdgeInsets.only(top: 20, left: 30, right: 20),
            leading: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration (
                image: DecorationImage (
                  fit: BoxFit.cover,
                  image: AssetImage('assets/phone1.png'),
                ),
              ),
            ),
            title: Text("Phone : + 1847 219 8377"),

          ),

        ],
      ),
    );
  }
  void _showDialog() {
    // flutter defined function

  }
}
