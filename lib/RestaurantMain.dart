import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/map.dart';
import 'package:flutterapp/restaurantBottomBar/restaurantAccount.dart';
import 'package:flutterapp/restaurantDrawer/ResturantStories.dart';
import 'package:flutterapp/restaurantDrawer/Notifications.dart';
import 'package:flutterapp/restaurantDrawer/Subscriptions.dart';
import 'package:flutterapp/restaurantScreens/restaurantAnalytics.dart';
import 'package:flutterapp/Settings.dart';
import 'package:flutterapp/restaurantDrawer/shelterDetails.dart';
import 'Home.dart';
import 'main.dart';

class RestaurantMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material",
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/shelter': (BuildContext context) => ShelterDetails(),
        '/main': (BuildContext context) => MaterialDesign(),
        '/restaurantAnalytics': (BuildContext context) => AnalyticsBody(),
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
                  .collection("Restaurant")
                  .document(user.data.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                //print(snapshot.data);
                if (snapshot.hasData) {
                  return Text(snapshot.data[data]);
                }
                else {
                  return Text("");
                }
              });
        }
      });
}

class Home extends StatefulWidget {
  @override
  RestaurantState createState() => RestaurantState();
}

class RestaurantState extends State<Home> {
  final bottomBarItems = [
    HomeScreen(),
    MapSample(),
    Container(
      child: Center(child: fetch("displayName")),
    ),
    RestaurantAccount(),
  ];
  //String restaurantName = fetch("displayName");
  Color mainColor = Colors.green;
  Widget roleTitle = fetch("displayName");
  String appBarTitle = "Home";
  int _bottomBarIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _bottomBarIndex = index;
      switch(index){
        case 0: appBarTitle = "Home";
        break;
        case 1: appBarTitle = "Map";
        break;
        case 2: appBarTitle = "Orders";
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
      body: bottomBarItems[_bottomBarIndex],
      appBar: AppBar(
        elevation: 10.0,
        title: Text(appBarTitle),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: mainColor,
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
            icon: Icon(Icons.bookmark_border),
            title: Text("Orders"),
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
                            "Restaraunt Name",
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
                Navigator.of(context).pushNamed('/shelter');
              },
              leading: Icon(Icons.home),
              title: Text("Shelter Details"),
            ),
            ListTile(             //Creates the Analytics section.
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/restaurantAnalytics');
              },
              leading: Icon(Icons.insert_chart),
              title: Text("Analytics"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Stories()));
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
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Subscriptions()));
              },
              leading: Icon(Icons.subscriptions),
              title: Text("Subscriptions"),
            ),
            Divider(
              height: 15.0,
              thickness: 0.5,
              color: Colors.green,
              indent: 20.0,
              endIndent: 20.0,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
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
