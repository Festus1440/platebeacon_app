import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/map.dart';
import 'package:flutterapp/restaurantBottomBar/pickup.dart';
import 'package:flutterapp/restaurantBottomBar/restaurantAccount.dart';
import 'package:flutterapp/restaurantDrawer/ResturantStories.dart';
import 'package:flutterapp/restaurantDrawer/Notifications.dart';
import 'package:flutterapp/restaurantDrawer/Subscriptions.dart';
import 'package:flutterapp/Analytics/Restaurant/RestaurantHomeAnaytics.dart';
import 'package:flutterapp/restaurantsettings.dart';
import 'package:flutterapp/restaurantDrawer/shelterDetails.dart';
import 'Home.dart';
import 'main.dart';
import 'package:flutterapp/Analytics/Restaurant/GraphRestaurant.dart';

class RestaurantMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material",
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/shelter': (BuildContext context) => ShelterDetails(),
        '/main': (BuildContext context) => MaterialDesign(),
        '/analytics': (BuildContext context) => RestaurantAnalyticsHome(),
//      '/analytics' : (BuildContext context) => AnalyticsHomePage(),
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
                } else {
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
  bool visible = true;
  String size = "";
  String userId = "";
  String mainCollection = "";
  String subCollection = "";
  //Color mainColor;
  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
        if (user.displayName == "Shelter") {
          mainCollection = "Shelter";
          subCollection = "pickup";
          mainColor = Colors.blue;
        } else {
          mainCollection = "Restaurant";
          subCollection = "deliveries";
          mainColor = Colors.green;
        }
        //loading = false;
      });
      //countDon();
      //sleep(const Duration(seconds: 2));
    });
    countDocuments();
  }

  void countDocuments() async {
    QuerySnapshot _myDoc =
        await Firestore.instance.collection("donations").getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    //print(_myDocCount.length);  // Count of Documents in Collection
    setState(() {
      if(_myDocCount.length <= 0){
        visible = false;
      }
      else {
        visible = true;
        size = _myDocCount.length.toString();
      }
    });
  }

  Widget countDon() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection("donations")
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("");
          }
          else {
            String num = snapshot.data.documents.length.toString();
            if(num != null) {
              return Text(
                num,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              );
            }
            else {
              return Text("");
            }
          }
        });
  }

  final bottomBarItems = [
    HomeScreen(), // bottom bar items (0,1,2,3)
    MapSample(),
    Pickup(),
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
            icon: Stack(
              children: <Widget>[
                Icon(CupertinoIcons.heart),
                  Visibility(
                    visible: visible,
                    child: Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          size,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            title: Text("Donations"),
          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.person),
//            title: Text("Profile"),
//          ),
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
                      Navigator.of(context).pushNamed('/analytics'); //Analytics
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15)),
                            backgroundColor: Colors.white,
                            title: new Text("Help coming soon!"),
                            content: new Text(
                                "Yes, you might have questions and we'll have a help section shortly."
                                " For now directly ask the team!"),
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
                            content: new Text("Soon you will be able to favorite Shelters you work with"
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
