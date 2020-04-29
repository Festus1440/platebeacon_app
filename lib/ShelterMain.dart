import 'package:flutter/material.dart';
import 'package:flutterapp/Home.dart';
import 'package:flutterapp/ShelterDrawer/restaurantDetails.dart';
//import 'package:flutterapp/Settings.dart';
import 'package:flutterapp/restaurantDrawer/ResturantStories.dart';

//import 'ShelterDrawer/ShelterSettings.dart';
import 'restaurantsettings.dart';
import 'ShelterDrawer/ShelterStories.dart';
import 'map.dart';
import 'shelterBottomBarPages/shelterAccount.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/ShelterDrawer/Notifications.dart';

class ShelterMain extends StatelessWidget {
  //const ShelterMain({Key key, this.user}) : super(key: key);
  //final FirebaseUser user;
  // committed code

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material",
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/restaurant': (BuildContext context) => RestaurantDetails(),
        '/notifications': (BuildContext context) => Notifications(),
        '/main': (BuildContext context) => MaterialDesign(),
      },
    );
  }
}

Widget fetch(data) {
  return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot user) {
        if (user.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        } else {
          return StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection("Shelter")
                  .document(user.data.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Error");
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text("Loading");
                  default:
                  //String s = Text(snapshot.data[data]).data;
                    return Text(snapshot.data[data]);
                }
              });
        }
      });
}

class Home extends StatefulWidget {
  @override
  _MaterialHomeState createState() => _MaterialHomeState();
}

class _MaterialHomeState extends State<Home> {
  final bottomBarItems = [
    HomeScreen(),
    MapSample(),
    Container(
      child: Center(child: Text("")),
    ),
    ShelterAccount(),
  ];
  Color mainColor = Colors.blue;
  int _bottomBarIndex = 0; // the first page
  String appBarTitle = "Home";
  void _onItemTapped(int index) {
    setState(() {
      _bottomBarIndex = index;
      switch(index){
        case 0: appBarTitle = "Home";
        break;
        case 1: appBarTitle = "Map";
        break;
        case 2: appBarTitle = "Pickups";
        break;
        case 3: appBarTitle = "Account";
        break;
        default: appBarTitle = "Home";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text("Map"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            title: Text("Pickups"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Account"),
          ),
        ],
        currentIndex: _bottomBarIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      body: bottomBarItems[_bottomBarIndex],
      appBar: AppBar(
        elevation: 10.0,
        title: Text(appBarTitle),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              color: mainColor,
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
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Shelter Name",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            "Chicago, IL",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/restaurant');
              },
              leading: Icon(Icons.restaurant),
              title: Text("Restaurant Details"),
            ),
            ListTile(   //Creates the link to the analytics page.
              onTap: () {
                Navigator.of(context).pop();
//                setState(() {
//                  _bottomBarIndex = 1;
//                });
              },
              leading: Icon(Icons.insert_chart),
              title: Text("My Analytics"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShelterStories()));
              },
              leading: Icon(Icons.library_books),
              title: Text("Stories"),
            ),
            ListTile(

              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
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
              color: mainColor,
              indent: 20.0,
              endIndent: 20.0,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                //Navigator.push(context, MaterialPageRoute(builder: (context) => ShelterSettings()));
              },
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacementNamed('/main');
                });
              },
              leading: Icon(Icons.arrow_back),
              title: Text("Log out"),
            ),
          ],
        ),
      ),
    );

  }
}