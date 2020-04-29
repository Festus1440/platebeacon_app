import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutterapp/AccountSettings.dart';
import 'package:flutterapp/restaurantBottomBar/restaurantAccount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/restaurantDrawer/Notifications.dart';
import 'package:flutterapp/restaurantDrawer/Subscriptions.dart';
import 'ShelterDrawer/Notifications.dart';
import 'accountsettings.dart';

Color mainColor;

class RestaurantSettings extends StatefulWidget {
  @override
  _RestaurantSettingsState createState() => _RestaurantSettingsState();
}

class _RestaurantSettingsState extends State<RestaurantSettings> {
  String userId;
  String personName;
  String email;
  String role;

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

  getData() async {
    await Firestore.instance
        .collection("Restaurant")
        .document(userId)
        .get()
        .then((DocumentSnapshot data) {
      personName = data["displayName"] ?? "Null";
      email = data["email"] ?? "null";
      role = data["role"] ?? "null";
      print(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Settings"),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 20.0,
          color: mainColor,
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      child: Text(
                        "Edit profile",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RestaurantAccountDetails()));
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      "Change your name,description and profile photo.",
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
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
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          child: Text(
                            "Account Settings",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AccountSettingsDetails()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 5.0, left: 15.0),
                  child: Text(
                    "Change your email or delete your account.",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  height: 20.0,
                  thickness: 0.5,
                  color: mainColor,
                  indent: 0.0,
                  endIndent: 0.0,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                        child: GestureDetector(
                            child: Text(
                              "Notifications",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder:(context) => RestaurantNotifications()));

                          },

                        )
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 5.0, left: 15.0),
                  child: Text("Define what alerts and notifications you want to see.",style: TextStyle(
                    fontSize: 10.0,fontWeight:FontWeight.bold,
                  ),),
                ),
                Divider(
                  height: 20.0,
                  thickness: 0.5,
                  color: mainColor,
                  indent: 0.0,
                  endIndent: 0.0,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                      child: GestureDetector(
                        child: Text("Subscriptions",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,
                        ),
                        ),
                        onTap: (){Navigator.push( context,
                        MaterialPageRoute(builder:(context) => Subscriptions()));

                        },



    )
    ),

    ],
                  ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 5.0, left: 15.0),
                  child: Text("Manage your subscriptions.",style: TextStyle(
                    fontSize: 10.0,fontWeight:FontWeight.bold,
                  ),),
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

    );
  }
}
