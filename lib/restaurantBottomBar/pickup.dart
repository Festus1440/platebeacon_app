import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pickup extends StatefulWidget {
  @override
  _PickupState createState() => _PickupState();
}

class _PickupState extends State<Pickup> {
  String userId = "";
  String mainCollection = "";
  String subCollection = "";
  Color mainColor;
  int size = 0;
  bool loading = true;

  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
        if (user.displayName == "Shelter") {
          mainCollection = "Shelter";
          subCollection = "pickup";
          mainColor = Colors.blue;
        } else {
          mainCollection = "Restaurant";
          subCollection = "deliveries";
          mainColor = Colors.green;
        }
        loading = true;
      });
      loading = false;
      //sleep(const Duration(seconds: 2));
    });
  }

  Future getLists() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection(mainCollection)
        .document(userId)
        .collection("deliveries")
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    if(loading == true){
      print(userId);
    }else{
      print("loaded" + userId);
      return new StreamBuilder(
        stream: Firestore.instance
            .collection("donations").orderBy('id')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: new Text('Loading...'));
          if (snapshot.data.documents.length <= 0) {
            return Center(child: Text("No Available Donations"));
          }
          else {
          return new ListView(
            children: snapshot.data.documents.map((document) {
              return ListTile(
                onTap: () {
                  // dont use for delete
                },
                leading: Container(
                  height: 50,
                  child: Icon(Icons.calendar_today),
                ),
                title: Text('Next Donation'),
                subtitle: Text(
                    document['date'] + " id: " + document['id'].toString()),
                trailing: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: mainColor),
                  height: 50,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2)),
                            backgroundColor: Colors.white,
                            title: Text("Delete Confirmation"),
                            content: Text(
                                "Are you sure you want to delete"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Yes"),
                                onPressed: () {
                                  print(document.documentID);
                                  Firestore.instance.collection("donations")
                                      .document(document.documentID)
                                      .delete()
                                      .then((oValue) {
                                    SnackBar(content: Text('Deleted'));
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete, color: Colors.white,),
                  ),
                ),
              );
            }).toList(),
          );
        }
        },
      );
    }
    return Center(child: Text("Loading..."));
  }
}
