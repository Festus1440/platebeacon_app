import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Color mainColor = Colors.green;

class  Settings extends StatelessWidget {
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
                    child: Text("Edit profile",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(
                      "Change your name,description and profile photo.",style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold,
                    ),),)
                ],),),
            Divider(
              height: 20.0,
              thickness: 0.5,
              color: mainColor,
              indent: 0.0,
              endIndent: 0.0,
            ),
            Column(
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Account Settings",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,
                      ),),
                    )
                  ],),),
                Container(
                  alignment:Alignment.topLeft ,
                  padding: EdgeInsets.only(top: 3.0),
                  child: Text("Change your email or delete your account.",style: TextStyle(fontSize: 10.0,fontWeight:FontWeight.bold,
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
