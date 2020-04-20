import 'package:flutter/material.dart';
//import 'main.dart';

Color mainColor = Colors.green;

class RestaurantAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                //contentPadding: EdgeInsets.only(left: 15.0, right: 5.0, top: 5.0, bottom: 10.0,),
                onTap: () {
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  //margin: EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    //border: Border.all(width: 0.0, color: mainColor),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/PB.jpg'),
                    ),
                  ),
                ),
                title: Text("Name of Profile"),
                subtitle: Text("View account"),
              ),
              Divider(
                height: 0.0,
                thickness: 0.5,
                color: mainColor,
                indent: 0.0,
                endIndent: 0.0,
              ),
            ],
          ),
          ListTile(
            onTap: () {
            },
            leading: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.favorite)
            ),
            title: Text("Favorites"),
          ),
          ListTile(
            onTap: () {
            },
            leading: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.help)
            ),
            title: Text("Help"),
          ),
          ListTile(
            onTap: () {
            },
            leading: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.credit_card)
            ),
            title: Text("Payment Options"),
          ),
          ListTile(
            onTap: () {
            },
            leading: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.info)
            ),
            title: Text("About"),
          ),
        ],
      ),
    );
  }
}
