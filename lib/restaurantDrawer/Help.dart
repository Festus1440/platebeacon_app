import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:share/share.dart';


Color mainColor = Colors.green;
class Help extends StatefulWidget{
  @override
  HelpState createState() => HelpState();

}
class HelpState extends State<Help> {
Color mainColor;
  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
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
                width: 200,
                height: 200,
                decoration: BoxDecoration (
                    image: DecorationImage (
                      fit: BoxFit.cover,
                      image: AssetImage('assets/PB.jpg'),
                    )
                ),
              )
          ),

          Container(
              child: Column (
                children: <Widget>[
                  //Column(
                  //children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                    alignment: Alignment.topCenter,
                    child: Text(
                      "If you need any help please contact us via ",
                      style: TextStyle(
                        fontSize: 20.0,
                        // fontWeight:FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
          ),
          SizedBox(height: 40,),
          ListTile(
            onTap: (){
              print("press");
            },
            contentPadding: EdgeInsets.only(left: 30, right: 30),
            leading: Icon(Icons.email),
            title: Text("Email: platebeacon@gmail.com"),
          ),
          SizedBox(height: 10,),
          ListTile(
            onTap: (){
              print("press to instagram");
            },
            contentPadding: EdgeInsets.only(left: 30, right: 30),
            leading: Icon(Icons.phone),
            title: Text("Phone : + 1847 219 8377"),
          ),
        ],
      ),
    );
  }
}
