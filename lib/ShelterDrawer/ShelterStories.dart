import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:share/share.dart';


Color mainColor = Colors.blue;


class ShelterStories extends StatefulWidget{
  @override
  ShelterStoriesState createState() => ShelterStoriesState();
}

class ShelterStoriesState extends State<ShelterStories> {

  @override
  void initState() {
    super.initState();
    Timer.run(() => _showDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stories"),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 20.0,
          color: mainColor,
        ),
      ),
      body: Column (
        children: <Widget>[
          Center(
              child: Container (
                height: 200,
                decoration: BoxDecoration (
                    image: DecorationImage (
                      fit: BoxFit.cover,
                      image: AssetImage('assets/Stories.jpg'),
                    )
                ),
              )
          ),
          Divider(
            height: 10,
            thickness: 5,
            color: mainColor,
            indent: 0.0,
            endIndent: 0.0,
          ),
          Container(
            child: Column (
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Share Story",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],

            ),

          ),
          Divider(
            height: 40.0,
            thickness: 5,
            color: mainColor,
            indent: 0.0,
            endIndent: 0.0,
          ),
          ListTile(
            onTap: (){
              print("press");
            },
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            leading: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration (
                image: DecorationImage (
                  fit: BoxFit.cover,
                  image: AssetImage('assets/facebook1.png'),
                ),
              ),
            ),
           title: Text("Facebook"),
            trailing: Icon(Icons.more_vert),
          ),
          /*FlatButton(
            onPressed: (){
              "Comming Soon";
            },
            child: Text(
              "Behnaz",

            )

          ),*/

          ListTile(
            onTap: (){
              print("press to instagram");
            },
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            leading: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration (
                image: DecorationImage (
                  fit: BoxFit.cover,
                  image: AssetImage('assets/instagram1.png'),
                ),
              ),
            ),
            title: Text("Instagram"),
            trailing: Icon(Icons.more_vert),
          ),

        ],
      ),
    );
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text("Stories coming soon!"),
          content: new Text("Soon you'll be able to share your experiences using Plate Beacon to all your fans!"
              " Be proud of the contributions you've made to help those in need! We Applaud you!"),
          actions: <Widget>[
            new FlatButton(
              child: new
              Text("Sounds good!") ,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

