import 'package:flutter/material.dart';


class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: Colors.blue,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/PB.jpg'),
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Shelter Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          "Chicago, IL",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: Icon(Icons.restaurant),
            title: Text("Restaurant Details"),
          ),
          ListTile(
            onTap: () {
              //Navigator.of(context).pushNamed(main.routeName);
            },
            leading: Icon(Icons.insert_chart),
            title: Text("Analytics"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: Icon(Icons.library_books),
            title: Text("Stories"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: Icon(Icons.event),
            title: Text("Events"),
          ),
          Divider(
            height: 15.0,
            thickness: 0.5,
            color: Colors.black38,
            indent: 20.0,
            endIndent: 20.0,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: Icon(Icons.arrow_back),
            title: Text("Log out"),
          ),
        ],
      ),
    );
  }
}