import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Home.dart';

import 'main.dart';
//import 'package:flutterapp/ShelterDrawer/restaurantDetails.dart';


class AccountSettingsDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountSettingsDetails> {
  //bool tappedYes = false;
  String role;
  FirebaseUser userObject;
  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userObject = user;
        if (user.displayName == "Shelter") {
          role = "Shelter";
          mainColor = Colors.blue;
          //print(mainCollection);
        } else {
          role = "Restaurant";
          mainColor = Colors.green;
          //print(mainCollection);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
        backgroundColor: mainColor,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              //margin: EdgeInsets.only(top: 15.0, left: 30.0, right: 15.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    //contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                    title: Text(
                      "Change Email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                    },
                  ),
                  Divider(
                    height: 0.0,
                    thickness: 0.5,
                    color: Colors.black,
                    indent: 0.0,
                    endIndent: 0.0,
                  ),
                  ListTile(
                    //contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                    title: Text(
                      "Delete Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //subtitle: Text("Change your name,description and profile photo."),
                    onTap: () {
                      //print(userObject.toString());
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:  BorderRadius.circular(2)),
                            backgroundColor: Colors.white,
                            title:  Text("Delete Confirmation"),
                            content:  Text(
                                "Are you sure you want to delete"),
                            actions: <Widget>[
                              FlatButton(
                                child:  Text("Yes"),
                                onPressed: () {
                                  Firestore.instance.collection(role).document(userObject.uid).delete().then((value) {
                                    print("value");
                                    Navigator.of(context).pop();
                                    //userObject.delete()
                                    //userObject.delete().then((value) {

                                    //});
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MaterialDesign()));
                                  });
                                },
                              ),
                              FlatButton(
                                child:  Text("No"),
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
                  Divider(
                    height: 0.0,
                    thickness: 0.5,
                    color: Colors.black,
                    indent: 0.0,
                    endIndent: 0.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
