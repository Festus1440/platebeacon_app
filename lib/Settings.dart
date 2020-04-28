import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/AccountSettings.dart';
import 'package:flutterapp/restaurantBottomBar/restaurantAccount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ShelterDrawer/accountsettings.dart';
import 'accountsettings.dart';

Color mainColor = Colors.green;

class Settings extends StatelessWidget {
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
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingsDetails()));
                          },
                        ),
                      )

                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 5.0,left: 15.0),
                  child:Text(
                    "Change your email or delete your account.",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),



    );
  }
}





class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference sheltercollection =
      Firestore.instance.collection('Shelter');
  Future updateUserData(
      String ShelterName, String Email, String Password) async {
    return await sheltercollection.document(uid).setData({
      'ShelterName': ShelterName,
      'Email': Email,
      'Password': Password,
    });
  }

  //get Shelter stream
  Stream<QuerySnapshot> get shelter {
    return sheltercollection.snapshots();
  }
}

