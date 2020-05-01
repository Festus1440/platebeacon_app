import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutterapp/restaurantBottomBar/pickup.dart';

var _controller = TextEditingController();
Color mainColor = Colors.green;

Widget whatUser() {
  //logged in
  return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot user) {
        //print(user.data);
        if (user.connectionState == ConnectionState.waiting) {
          return Center(child: Text("Please wait..."));
        } else {
          if (user.data.displayName == "Shelter") {
            return ShelterHome();
          } else if (user.data.displayName == "Restaurant") {
            return RestaurantHome();
          } else {
            return Error();
          }
        }
      });
}
String selectedTime = "";
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  //margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                  decoration: BoxDecoration(
                      //borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      //border: Border.all(width: 1.0, color: mainColor),
                      //shape: BoxShape.circle,
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/food.jpg'),
                  )),
                ),
                SizedBox(height: 10.0),
                whatUser(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantHome extends StatefulWidget {
  @override
  _RestaurantHomeState createState() => _RestaurantHomeState();
}

class _RestaurantHomeState extends State<RestaurantHome> {
  int size = 0;
  String userId = "";
  String mainCollection = "";
  String subCollection = "";
  DateTime _dateTime;
  TimeOfDay _timeOfDay = TimeOfDay.now();
  String selectedDate = "No Scheduled Donations";
  int id = 0;

  String formattedTimeOfDay;
  // TimeOfDay res = TimeOfDay.fromDateTime(DateTime.now());
  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      if (!mounted) return;
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
      });
      countDocuments();
      //sleep(const Duration(seconds: 2));
    });
  }

  void countDocuments() async {
    QuerySnapshot _myDoc = await Firestore.instance.collection("donations").getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    //print(_myDocCount.length);  // Count of Documents in Collection
    if (!mounted) return;
    setState(() {
      size = _myDocCount.length;
      id = size+1;
    });
  }

  update() {
    Firestore.instance
        .collection("donations").document().setData({
      'date': selectedDate + selectedTime,
      "id": size+1,
        }).then((onValue) {
    });
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (picked != null) {
      print(_timeOfDay);
      if (!mounted) return; // make sure not to run if its not mounted aka available saves memory
      setState(() {

        _timeOfDay = picked;
      });
      final MaterialLocalizations localizations =
          MaterialLocalizations.of(context);
      String formattedTimeOfDay = localizations.formatTimeOfDay(_timeOfDay);
      print(formattedTimeOfDay);
      selectedTime = " at " + formattedTimeOfDay;
    }
    update();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.menu),
            title: Container(
              margin: EdgeInsets.only(left: 0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => _controller.clear(),
                    icon: Icon(Icons.close),
                  ),
                  hintText: "Location",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          child: ListTile(
            onTap: () {
              showDatePicker(
                      context: context,
                      // the helptext: below wasn't working for everyone revisit
                      //helpText: "Please Pick a date to Schedule Pickup",
                      initialDate:
                          _dateTime == null ? DateTime.now() : _dateTime,
                      firstDate: DateTime(2019),
                      lastDate: DateTime(2222))
                  .then((date) {
                //print(date.month.toString() + "/" + date.day.toString() + "/" + date.year.toString());
                if (!mounted)
                  return; // make sure not to run if its not mounted aka available saves memory
                setState(() {
                  if (date != null) {
                    _dateTime = date;
                    selectedDate = date.month.toString() +
                        "/" +
                        date.day.toString() +
                        "/" +
                        date.year.toString();
                    selectTime(context);
                  }
                });
              });
            },
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.calendar_today),
            title: Container(
                margin: EdgeInsets.only(
                  left: 0,
                ),
                child: Text("Schedule Delivery")), //
          ),
        ),
        Container(
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Container(
                height: 50,
                child: Text(
                  "",
                ),
            ),
            title: Container(
                margin: EdgeInsets.only(left: 0), child: Text("Next Donation")),
            subtitle: Container(
                margin: EdgeInsets.only(left: 0),
                child: fetch("No Scheduled Donations"),
            ),
            //trailing:
          ),
        ),
      ],
    );
  }
}

Widget fetch(message){
  return StreamBuilder(
    stream: Firestore.instance
        .collection("donations")
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasData)
      {
        if(snapshot.data.documents.length <= 0){
          return Text(message);
        }
        else {
          var data = snapshot.data.documents.first['date'];
          if (data == null) {
            data = message;
            return Text(data.toString());
          }
          else {
            return Text(data.toString());
          }
        }
      }
      else {
        return Center(child: new Text('Checkimg...'));
      }
    },
  );
}

class ShelterHome extends StatefulWidget {
  @override
  _ShelterHomeState createState() => _ShelterHomeState();
}

class _ShelterHomeState extends State<ShelterHome> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.menu),
            title: Text("Location"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.close),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          child: ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15)),
                    backgroundColor: Colors.white,
                    title: new Text("Food request coming soon!"),
                    content: new Text(
                        "Getting too many potatoes? Let's go ahead and share that information so we "
                            "can share the wealth elsewhere, and ensure you get the food you need! This will also "
                            "provide much needed data to see what foods are scarce, compared to whats easily accessable. "),
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
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.restaurant),
            title: Text("Request Food"),
          ),
        ),
        Container(
          child: ListTile(
            //onTap: (){},
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Container(height: 50, child: Icon(Icons.calendar_today)),
            title: Text("Next Donation"),
            subtitle: fetch("No Available Donations"),
          ),
        ),
      ],
    );
  }
}

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Error");
  }
}
