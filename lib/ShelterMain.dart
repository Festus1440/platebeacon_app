import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Home.dart';
import 'package:flutterapp/ShelterDrawer/restaurantDetails.dart';
import 'package:flutterapp/restaurantBottomBar/pickup.dart';
import 'package:flutterapp/restaurantDrawer/Help.dart';
import 'package:flutterapp/restaurantDrawer/ResturantStories.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutterapp/Settings.dart';
//import 'package:flutterapp/restaurantDrawer/ResturantStories.dart';
//import 'restaurantsettings.dart';
import 'ShelterDrawer/ShelterStories.dart';
import 'custom-widget.dart';
import 'map.dart';
import 'shelterBottomBarPages/shelterAccount.dart';
import 'main.dart';
//import 'package:flutterapp/ShelterScreens/shelterAnalytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/ShelterDrawer/Notifications.dart';
import 'package:flutterapp/ShelterDrawer/Events.dart';
import 'package:flutterapp/ShelterDrawer/ShelterSettings.dart';
import 'package:flutterapp/Analytics/Shelter/ShelterMainAnalytics.dart';


class ShelterMain extends StatelessWidget {
  //const ShelterMain({Key key, this.user}) : super(key: key);
  //final FirebaseUser user;
  // committed code

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Plate Beacon",
      home: Home(),
    );
  }
}

Widget fetch(data) {
  return Text("");
}

class Home extends StatefulWidget {
  @override
  _MaterialHomeState createState() => _MaterialHomeState();
}

class _MaterialHomeState extends State<Home> {
  //String userId;
  String name = "Shelter Name";
  String city = "City";
  String state = "State";
  Completer<GoogleMapController> _mapController = Completer();
  Future<String> _getDataFromSharedPref(key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data == null){
      return null;
    }
    return data;
  }

  Future<void> _setSharedPref(key, String) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, String);
  }

  Future<void> _deleteData(key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(name),
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
        icon: Icon(Icons.shopping_basket),
        title: ("Pickups"),
        activeColor: Colors.white,
        inactiveColor: Colors.black,
      ),
    ];
  }

  Color mainColor = Colors.blue;
  int _bottomBarIndex = 0; // the first page
  String appBarTitle = "Home";
  void _onItemTapped(int index) {
    if (!mounted) return;
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
          appBarTitle = "Pickups";
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
          navBarHeight: 60,
          screens: _buildScreens(),
          items: _navBarsItems(), // Redundant here but defined to demonstrate for other than custom style
          confineInSafeArea: false,
          backgroundColor: Colors.blue,
          handleAndroidBackButtonPress: true,
          onItemSelected: (int) {
            _onItemTapped(int);
            if (!mounted) return;
            setState(() {

            }); // This is required to update the nav bar if Android back button is pressed
          },
          itemCount: 3,
          navBarStyle:
          NavBarStyle.style9 // Choose the nav bar style with this property
      ),
      appBar: AppBar(
        elevation: 10.0,
        title: Text(appBarTitle),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(icon: Icon(Icons.settings),
            onPressed: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ShelterSettings("Shelter")));
            },)
        ],
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
                          SizedBox(height: 5,),
                          Text(
                            "${city}${state == null || state == "" ? "": ", "+ state}",
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
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetails()));
                      },
                      leading: Icon(Icons.restaurant),
                      title: Text("Restaurant Details"),
                    ),
                    ListTile(
                      //Creates the link to the analytics page.
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ShelterMainAnalytics()));
                      },
                      leading: Icon(Icons.insert_chart),
                      title: Text("My Analytics"),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Stories("Shelter")));
                      },
                      leading: Icon(Icons.library_books),
                      title: Text("Stories"),
                    ),

                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Events()));
                      },
                      leading: Icon(Icons.event),
                      title: Text("Events"),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Help(), fullscreenDialog: true));
                        },
                      leading: Icon(Icons.help),
                      title: Text("Help"),
                    ),
                    ListTile(
                      onTap: () {
                        // flutter defined function
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
                              backgroundColor: Colors.white,
                              title: new Text("Favorites coming soon!"),
                              content: new Text("Soon you will be able to favorite Shelters you work with"
                                  " closely and view them all in one place!"),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("Sounds good!"),
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
                      color: mainColor,
                      indent: 20.0,
                      endIndent: 20.0,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ShelterSettings("Shelter")));
                      },
                      leading: Icon(Icons.settings),
                      title: Text("Settings"),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        FirebaseAuth.instance.signOut().then((value) {
                          //Navigator.of(context).pushReplacementNamed('/main');
                        });
                      },
                      leading: Icon(Icons.arrow_back),
                      title: Text("Log out"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
