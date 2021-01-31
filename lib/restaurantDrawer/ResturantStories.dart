import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:share/share.dart';

class Stories extends StatefulWidget{
  final String type;
  Stories(this.type);

  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  Color mainColor;

  @override
  void initState() {
    super.initState();
    if(widget.type == "Shelter"){
      mainColor = Colors.blue;
    }
    else {
      mainColor = Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stories"),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: BottomAppBar(
        color: mainColor,
        child: Padding(
          padding: EdgeInsets.all(20),
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
            height: 0,
            thickness: 1,
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
                        "Share your story",
                        style: TextStyle(
                          fontSize: 20.0,
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
            thickness: 1,
            color: mainColor,
            indent: 0.0,
            endIndent: 0.0,
          ),
          ListTile(
            onTap: (){
              print("press");
            },
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            leading: FaIcon(FontAwesomeIcons.facebook),
            title: Text("Facebook"),
            trailing: Icon(Icons.share),
          ),
          ListTile(
            onTap: (){
              print("press to instagram");
            },
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            leading: FaIcon(FontAwesomeIcons.instagram),
            title: Text("Instagram"),
            trailing: Icon(Icons.share),
          ),

        ],
      ),


    );
  }
}