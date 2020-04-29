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
  DateTime _dateTime;
  TimeOfDay _timeOfDay = TimeOfDay.now();
  String selectedDate = "No Scheduled Pickups";
  String selectedTime = "";
  String formattedTimeOfDay;
  // TimeOfDay res = TimeOfDay.fromDateTime(DateTime.now());

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (picked != null && picked != _timeOfDay) {
      setState(() {
        _timeOfDay = picked;
      });
      final MaterialLocalizations localizations =
          MaterialLocalizations.of(context);
      String formattedTimeOfDay = localizations.formatTimeOfDay(_timeOfDay);
      print(formattedTimeOfDay);
      selectedTime = " at " + formattedTimeOfDay;
      getData();

    }
  }

  @override
  void initState() {
    // this function is called when the page starts
    super.initState();

  }

  getData() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        if (user.displayName == "Shelter") {
          mainColor = Colors.blue;
          Firestore.instance
              .collection("Shelter")
              .document(user.uid).collection("pickup").document()
              .setData({
            'date': selectedDate+ "" +selectedTime.toString()
          }).then((onValue) {
            print("success");
          });
        } else {
          mainColor = Colors.green;
          Firestore.instance
              .collection("Restaurant")
              .document(user.uid).collection("deliveries").document()
              .setData({
            'date': selectedTime.toString()
          }).then((onValue) {
            print("success");
          });
        }
      });
    });
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
              margin: EdgeInsets.only(left: 50),
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
                  left: 50,
                ),
                child: Text("Schedule Delivery")), //
          ),
        ),
        Container(
          child: ListTile(
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Pickup()));
            },
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Container(
                height: 50,
                child: Icon(
                  Icons.notifications,
                )),
            title: Container(
                margin: EdgeInsets.only(left: 50), child: Text("Next Pickup")),
            subtitle: Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(selectedDate + selectedTime)),
            //trailing:
          ),
        ),
      ],
    );
  }
}

class ShelterHome extends StatelessWidget {
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
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.location_on),
            title: Text("Request Food"),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      backgroundColor: Colors.white,
                      title: new Text("Function coming soon!"),
                      content: new Text("This will be updated to do .."),
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
              icon: Icon(Icons.restaurant),
            ),
          ),
        ),
        Container(
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.access_time),
            title: Text("Drop off Time"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.calendar_today),
            ),
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
