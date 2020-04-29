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
            .collection("Restaurant")
            .document(userId)
            .collection("deliveries")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: new Text('Loading...'));
          return new ListView(
            children: snapshot.data.documents.map((document) {
              return new ListTile(
                onTap: (){

                },
                leading: Container(
                  height: 50,
                  child: Icon(Icons.calendar_today),
                ),
                title: new Text('Next Donation'),
                subtitle: new Text(document['date']),
              );
            }).toList(),
          );
        },
      );
    }
    return Center(child: Text("Loading..."));
  }
}
