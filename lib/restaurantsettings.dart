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
  final String _type;

  RestaurantSettings(this._type);

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
    setState(() {
      if (widget._type == "Shelter") {
        mainColor = Colors.blue;
      } else {
        mainColor = Colors.green;
      }
    });
  }

  getData() async {
    await FirebaseFirestore.instance.collection
        ("Restaurant")
        .doc(userId)
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
        color: mainColor,
        child: Padding(
          padding: EdgeInsets.all(20),
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
                      builder: (context) => EditAccountDetails("Restaurant")));
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
                      builder: (context) => AccountSettingsDetails("Restaurant")));
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
            subtitle: Text("Manage your Subscriptions."),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Subscriptions()));
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
            subtitle:
                Text("Define what alerts and notifications you want to see."),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Notifications("Restaurant")));
            },
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
                    backgroundColor: Colors.white,
                    title: new Text("About"),
                    content: new Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Developers"),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("randomText"),
                                Text("randomText"),
                                Text("randomText"),
                                Text("randomText"),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Close"),
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
            title: Text(
              "About",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text("Find out what's new about us here."),
          ),
          ListTile(
            title: Text(
                "Payment Options",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15)),
                    backgroundColor: Colors.white,
                    title: new Text("Payment Options coming soon!"),
                    content: new Text(
                        "Feel FREE to use this app as part of our research, no need to pay right now! "),
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
          ),
        ],
      ),
    );
  }
}
