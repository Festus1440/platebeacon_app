import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Home.dart';
import 'main.dart';
//import 'package:flutterapp/ShelterDrawer/Events.dart';


class AccountSettingsDetails extends StatefulWidget {
  final String _type;

  AccountSettingsDetails(this._type,);

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountSettingsDetails> {
  var email = TextEditingController();
  String role;
  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
    setState(() {
      if (widget._type == "Shelter") {
        role = "Shelter";
        mainColor = Colors.blue;
        //print(mainCollection);
      } else {
        role = "Restaurant";
        mainColor = Colors.green;
        //print(mainCollection);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: BottomAppBar(
        color: mainColor,
        child: Padding(
          padding: EdgeInsets.all(20),
        ),
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
                    subtitle: Text("Change your login and notification email"),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
                            backgroundColor: Colors.white,
                            title: Text("Change Email"),
                            content: TextField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "New Email",
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Change"),
                                onPressed: () {
                                  print(email.text);
                                  //widget._currentUser.
                                },
                              ),
                              FlatButton(
                                child: Text("Cancel"),
                                //color: Colors.blueAccent,
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
                  ListTile(
                    //contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                    title: Text(
                      "Delete Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("Permanently delete my account"),
                    onTap: () {
                      //print(userObject.toString());
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            //shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(2)),
                            backgroundColor: Colors.white,
                            title:  Text("Delete Confirmation"),
                            content:  Text(
                                "Are you sure you want to delete"),
                            actions: <Widget>[
                              FlatButton(
                                child:  Text("Yes"),
                                onPressed: () {

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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
