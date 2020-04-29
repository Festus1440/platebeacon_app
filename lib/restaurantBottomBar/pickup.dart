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
        loading = false;
      });
      //sleep(const Duration(seconds: 2));
    });
  }

  Future getLists() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection(mainCollection).document(userId).collection("deliveries").getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getLists(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: Container(
                        height: 50,
                        child: Icon(Icons.calendar_today),
                      ),
                      title: Text("Next Pickup"),
                      subtitle: Text(snapshot.data[index].data["date"]),
                    );
                  });
            }
          }),
    );
  }
}
