import 'package:flutter/material.dart';
import 'package:flutterapp/ShelterDrawer/restaurantDetails.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShelterMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material",
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/restaurant': (BuildContext context) => RestaurantDetails(),
        '/main': (BuildContext context) => MaterialDesign(),
      },
    );
  }
}

List<Widget> makeListWidget(AsyncSnapshot snapshot) {
  return snapshot.data.documents.map<Widget>((document) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(document['FirstName']),
      subtitle: Text(document['LastName']),
    );
  }).toList();
}

Widget fireStoreSnap() {
  return Container(
    child: StreamBuilder(
        stream: Firestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              return ListView(
                children: makeListWidget(snapshot),
              );
          }
        }),
  );
}

Widget userLoggedIn() {
  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          body: Center(child: Text("Loading")),
        );
      } else {
        if (snapshot.hasData) {
          return fireStoreSnap();
        } else {
          return Text("Not logged in");
        }
      }
    },
  );
}

class Home extends StatefulWidget {
  @override
  _MaterialHomeState createState() => _MaterialHomeState();
}

class _MaterialHomeState extends State<Home> {
  String shelterName = 'Shelter Name';

  final bottomBarItems = [
    Container(
      child: Center(
        child: userLoggedIn(),
      ),
    ),
    Container(
      child: Center(
        child: Text("Search Page"),
      ),
    ),
    Container(
      child: Center(
        child: Text("Orders"),
      ),
    ),
    Container(
      child: Center(
        child: Text("Account Page"),
      ),
    ),
  ];
  int _bottomBarIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _bottomBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black38,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            title: Text('Orders'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
          ),
        ],
        currentIndex: _bottomBarIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      body: bottomBarItems[_bottomBarIndex],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(shelterName),
        backgroundColor: Colors.black38,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              color: Colors.black38,
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
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  _bottomBarIndex = 1;
                });
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
