import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/map.dart';
import 'package:flutterapp/restaurantBottomBar/pickup.dart';
import 'package:flutterapp/restaurantBottomBar/restaurantAccount.dart';
import 'package:flutterapp/restaurantDrawer/Help.dart';
import 'package:flutterapp/restaurantDrawer/ResturantStories.dart';
//import 'package:flutterapp/restaurantDrawer/Notifications.dart';
//import 'package:flutterapp/restaurantDrawer/Subscriptions.dart';
import 'package:flutterapp/restaurantsettings.dart';
import 'package:flutterapp/restaurantDrawer/shelterDetails.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'Analytics/Restaurant/RestaurantMainAnalytics.dart';
import 'Home.dart';
import 'custom-widget.dart';
import 'main.dart';
//import 'package:flutterapp/Analytics/Restaurant/RestaurantSavingCharts.dart';

class RestaurantMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Calibri'),
      debugShowCheckedModeBanner: false,
      title: "Plate Beacon",
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/shelter': (BuildContext context) => ShelterDetails(),
        '/main': (BuildContext context) => MaterialDesign(),
        //'/analytics': (BuildContext context) => RestaurantAnalyticsHome(),
        //'/analytics' : (BuildContext context) => AnalyticsHomePage(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  RestaurantState createState() => RestaurantState();
}

class RestaurantState extends State<Home> {
  bool visible = true;
  String size = "";
  String userId = "";
  String name = "Restaurant Name";
  String city = "City";
  String state = "State";
  //Color mainColor;
  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    FirebaseAuth.instance.currentUser().then((user) {
      if (!mounted) return;
      setState(() {
        userId = user.uid;
      });
      Firestore.instance
          .collection('Restaurant')
          .document(userId)
          .get()
          .then((document) {
        if (!mounted) return;
        setState(() {
          name = document['displayName'] ?? "Restaurant Name";
          city = document['city'] ?? "City";
          state = document['state'] ?? "St";
        });
      });
    });
    //countDocuments();
  }
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      MapSample(),
      Pickup(),
    ];
  }
  PersistentTabController _controller;
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColor: Colors.white,
        inactiveColor: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.map),
        title: ("Map"),
        activeColor: Colors.white,
        inactiveColor: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Stack(
          children: <Widget>[
            Icon(CupertinoIcons.heart),
          ],
        ),
        title: ("Donations"),
        activeColor: Colors.white,
        contentPadding: 1,
        inactiveColor: Colors.black,
      ),
    ];
  }
  void countDocuments() async {
    QuerySnapshot _myDoc =
        await Firestore.instance.collection("donations").getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    //print(_myDocCount.length);  // Count of Documents in Collection
    if (!mounted) return;
    setState(() {
      if (_myDocCount.length <= 0) {
        visible = false;
      } else {
        visible = true;
        size = _myDocCount.length.toString();
      }
    });
  }

  Widget fetch() {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot user) {
          if (user.connectionState == ConnectionState.waiting) {
            return Text("");
          } else {
            return StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("Restaurant")
                    .document(userId)
                    .collection("donations").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  //print(snapshot.data);
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data.documents.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                      ),
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return Text("");
                  }
                });
          }
        });
  }

  //String restaurantName = fetch("displayName");
  Color mainColor = Colors.green;
  String appBarTitle = "Home";
  int _bottomBarIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _bottomBarIndex = index;
      switch (index) {
        case 0:
          appBarTitle = "Home";
          break;
        case 1:
          appBarTitle = "Map";
          break;
        case 2:
          appBarTitle = "Donations";
          break;
        case 3:
          appBarTitle = "Account";
          break;
        default:
          appBarTitle = "Home";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(), // Redundant here but defined to demonstrate for other than custom style
          confineInSafeArea: false,
          backgroundColor: Colors.green,
          handleAndroidBackButtonPress: true,
          onItemSelected: (int) {
            if (!mounted) return;
            setState(
                    () {}); // This is required to update the nav bar if Android back button is pressed
          },
          customWidget: CustomNavBarWidget(
            items: _navBarsItems(),
            onItemSelected: (index) {
              if (!mounted) return;
              setState(() {
                _controller.index = index; // THIS IS CRITICAL!! Don't miss it!
              });
            },
            selectedIndex: _controller.index,
          ),
          itemCount: 3,
          navBarStyle:
          NavBarStyle.simple // Choose the nav bar style with this property
      ),
      appBar: AppBar(
        elevation: 10.0,
        title: Text(appBarTitle),
        backgroundColor: mainColor,
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
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            city + ", " + state,
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
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('/shelter');
                    },
                    leading: Icon(Icons.home),
                    title: Text("Shelter Details"),
                  ),
                  ListTile(
                    //Creates the Analytics section.
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RestaurantMainAnalytics()));
                    },
                    leading: Icon(Icons.insert_chart),
                    title: Text("Analytics"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Stories()));
                    },
                    leading: Icon(Icons.library_books),
                    title: Text("Stories"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Help(),
                              fullscreenDialog: true));
                    },
                    leading: Container(child: Icon(Icons.help)),
                    title: Text("Help"),
                  ),

                  //ListTile(
                  //onTap: () {
                  //  Navigator.of(context).pop();
                  //  Navigator.push(context, MaterialPageRoute(
                  //    builder: (context) => Notifications()));
                  // },
                  //leading: Icon(Icons.notifications),
                  //title: Text("Notifications"),

                  //),
                  //ListTile(
                  // onTap: () {
                  //  Navigator.of(context).pop();
                  // },
                  // leading: Icon(Icons.event),
                  // title: Text("Events"),
                  //),
                  //ListTile(
                  //onTap: () {
                  // Navigator.of(context).pop();
                  //Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) => Subscriptions()));
                  //},
                  //leading: Icon(Icons.subscriptions),
                  // title: Text("Subscriptions"),
                  //),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15)),
                            backgroundColor: Colors.white,
                            title: new Text("Favorites coming soon!"),
                            content: new Text(
                                "Soon you will be able to favorite Shelters you work with"
                                " closely and view them all in one place!"),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text("Sounds good!"),
                                textColor: Colors.green,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    leading: Container(
                        //margin: EdgeInsets.only(left: 10.0),
                        child: Icon(Icons.favorite)),
                    title: Text("Favorites"),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RestaurantSettings()));
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
          ],
        ),
      ),
    );
  }
}
