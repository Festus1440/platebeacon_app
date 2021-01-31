import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pickup extends StatefulWidget {
  @override
  _PickupState createState() => _PickupState();
}

class _PickupState extends State<Pickup> {
  bool isShelter;
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
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
    } else {
      //print("loaded" + userId);
      return new StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(mainCollection)
            .doc(userId)
            .collection(subCollection)
            .orderBy('id')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: new CircularProgressIndicator());
          if (snapshot.data.docs.length <= 0) {
            return Center(
                child: Text(isShelter
                    ? "Donations that have been sent to you will show here"
                    : "Donations that you have made will show here"));
          } else {
            return new ListView(
              //padding: EdgeInsets.all(15),
              children: snapshot.data.docs.map((document) {
                return InkWell(
                  //onTap: (){},
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.favorite),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        document['name'].toString() +
                                            " Donation",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("Scheduled For: " +
                                          document['date'].toString()),
                                      Text(isShelter
                                          ? "From " +
                                              document['from'].toString()
                                          : "For " + document['to'].toString()),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Delete Confirmation"),
                                          content: Text(
                                              "Are you sure you want to delete"),
                                          actions: <Widget>[
                                            MaterialButton(
                                              child: Text("Yes"),
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection(mainCollection)
                                                    .doc(userId)
                                                    .collection(subCollection)
                                                    .doc(document.id)
                                                    .delete()
                                                    .then((onValue) {
                                                  print("deleted" +
                                                      " " +
                                                      document.id);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              color: Colors.redAccent,
                                              elevation: 0.0,
                                              highlightElevation: 0.0,
                                            ),
                                            MaterialButton(
                                              child: Text("No"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              color: Colors.cyanAccent,
                                              elevation: 0.0,
                                              highlightElevation: 0.0,
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 0,
                          thickness: 1,
                        ),
                      ],
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
