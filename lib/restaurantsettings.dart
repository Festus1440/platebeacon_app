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
      body: ListView(
        children: <Widget>[
          ListTile(
            //contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
            title: Text(
              "Edit Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text("Change your name,description and profile photo."),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RestaurantAccountDetails()));
            },
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
            title: Text(
              "Account Settings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text("Change your email or delete your account."),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountSettingsDetails()));
            },
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
            title: Text(
              "Subscriptions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text("Manage your Subscriptions"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Subscriptions()));
            },
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
            title: Text(
              "Notifications",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text("Define what alerts and notifications you want to see"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RestaurantNotifications()));
            },
          ),
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: GestureDetector(
                child: Text("Payment Options",style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,
                ),
                ),
                onTap: (){     showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      backgroundColor: Colors.white,
                      title: new Text("Payment Options coming soon!"),
                      content: new Text("Feel FREE to use this app as part of our research, no need to pay right now! "),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Sounds good!"),
                          textColor: Colors.green,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );

                },



              )
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 5.0, left: 15.0),
            child: Text("Select different payment options.",style: TextStyle(
              fontSize: 15.0,
            ),),
          ),
        ],
      ),
    );
  }
}
