import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.menu),
            title: TextField(
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
        SizedBox(height: 10.0),
        Container(
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.location_on),
            title: Text("Schedule Pickup"),
            trailing: IconButton(
              onPressed: () {
                showDatePicker(context: context,
                    //helpText: "Please Pick a date to Schedule Pickup",
                    initialDate: _dateTime == null ? DateTime.now() :
                    _dateTime,
                    firstDate: DateTime(2019),
                    lastDate: DateTime(2222)).then((date){
                  print(date);
                  setState((){
                    _dateTime = date;
                  });
                });
              },
              icon: Icon(Icons.calendar_today),
            ),  //
          ),
        ),
        Container(
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.location_on),
            title: Text(_dateTime.toString()),
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
              onPressed: () {},
              icon: Icon(Icons.calendar_today),
            ),
          ),
        ),
        Container(
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.location_on),
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