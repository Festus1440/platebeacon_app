import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Analytics/Shelter/FoodRequesAnalytics.dart';
import 'package:flutterapp/Analytics/Shelter/TopContributors.dart';
import 'package:flutterapp/Analytics/Shelter/FoodDonationsAnalytics.dart';
import 'dart:async';


class ShelterMainAnalytics extends StatefulWidget{
  @override
  _ShelterMainAnalyticsState createState() => _ShelterMainAnalyticsState();
}

class _ShelterMainAnalyticsState extends State<ShelterMainAnalytics> {

  @override
  void initState() {
    super.initState();
    Timer.run(() => _showDialog());
  }

  int _currentIndex = 0;

  final bottomBarItems = [
    FoodDonationsAnalytics(),
    TopContributors(),
    FoodRequestAnalytics(),
  ];

//  void _onItemTapped(int index) {
//    print(_currentIndex);
//    setState(() {
//      _currentIndex = index;
//    });
//  }

  //Function: Takes on parameter an sets the index of the currently selected widget
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        _showDialogSavings();
        break;
      case 1:
        _showDialogRanking();
        break;
      case 2:
        _showDialogEarnings();
        break;
      default:
        _showDialog();
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Analytics"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.flag),
              title: Text('Food Donations')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Top Contributor'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              title: Text('Food Request')
          )
        ],
      ),
      body: bottomBarItems[_currentIndex],
    );
  }

  ///Functions containing the pop up boxes
  void _showDialog() {
// flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          elevation: 0.0,
          shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text("My Analytics coming soon!"),

          content: new Text("Here is where all analytics will be displayed, please click the bottom buttons for further details!"),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
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
  }

  void _showDialogSavings() {
// flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          elevation: 0.0,
          shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text("Food Donations coming soon!"),

          content: new Text("Soon you will be able to see your weekly, monthly, and yearly donations as a result of "
              "donating rather than disposal! "),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
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
  }

  void _showDialogRanking() {
// flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          elevation: 0.0,
          shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text("Top Contributor coming soon"),

          content: new Text("Check which restaurant donates the most to your shelter! This will help you  "
              "evaluate what type of food you are most likely to get!"),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Sounds good"),
              textColor: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogEarnings() {
// flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          elevation: 0.0,
          shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text("Food Request coming soon"),

          content: new Text("This section of the app will allow the user to see the type of food being consumed to most! This is where you will see"
              " Total food request! "),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
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
  }
}
