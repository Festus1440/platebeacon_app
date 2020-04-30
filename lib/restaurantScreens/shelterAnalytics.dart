import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutterapp/restaurantScreens/AnalyticsPage.dart';
import 'package:flutterapp/restaurantScreens/RestaurantRating.dart';
import 'package:flutterapp/restaurantScreens/Earning.dart';
import 'dart:async';

class AnalyticsHomePage extends StatefulWidget{
  @override
  _HomePageAnalytics createState() => _HomePageAnalytics();
 }

class _HomePageAnalytics extends State<AnalyticsHomePage>{

  @override
  void initState() {
    super.initState();
    Timer.run(() => _showDialog());
  }

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
  }


  int _currentIndex = 0;

  final _page = [
    SavingTotal(),
    RatingPage(),
    EarningsTotal(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Analytics',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Analytics'),
        ),
        body: _page[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (int index){
            setState(() {
              _currentIndex = index;
              _onItemTapped(index);   //Set the pop up message
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on),
                title: Text('Saving')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text('Ranking'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money),
                title: Text('Earnings')
            )
          ],
        ),
      ),
    );
  }



//  Creating the section for the pop up
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
          title: new Text("Savings coming soon!"),

          content: new Text("Soon you will be able to see your weekly, monthly, and yearly savings as a result of "
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
          title: new Text("Ranking coming soon"),

          content: new Text("See where you stand out among other restaurant donators! Word is this will "
              "become a focal point of our rewards program!"),
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
          title: new Text("Earnings coming soon"),

          content: new Text("Future versions of this app will allow meal purchases by your clients! This is where you will see"
              " any earnings gained by this feature! "),
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