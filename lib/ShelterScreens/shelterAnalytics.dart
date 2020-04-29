//Implementation by Jose Heras on 04/27/2020

import 'dart:async';

import 'package:flutter/material.dart';



class shelterAnalytics extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnalyticsBody(),
    );
  }
}

class AnalyticsBody extends StatefulWidget{
  AnalyticsBody({Key key}) : super (key: key);

  @override
  _AnalyticsBodyState createState() => _AnalyticsBodyState();
}

class _AnalyticsBodyState extends State<AnalyticsBody> {

  @override
  void initState() {
    super.initState();
    Timer.run(() => _showDialog());
  }

  int _selectedIndex = 0;

  //Defines a constant style for body widgets
  static const TextStyle optionStyle =
  TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
  );

  //Will store data to displayed on the screen when a button icon is selected.
  //Currently it contains only text
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Savings',
      style: optionStyle,
    ),
    Text(
      'Coming Soon',
      style: optionStyle,
    ),
    Text(
      'Coming Soon',
      style: optionStyle,
    )
  ];

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
      default:_showDialog();
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  //Builds the overall view of the Analytics page
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar( //Top Bar.
          backgroundColor: Colors.blue,
          title: Text("My Analytics"),
        ),
        body: Center( //Body of the screen
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar( //Lower navigation.
          backgroundColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            //Contains the lower icons on the screen
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money),
                title: Text('Savings')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                title: Text('Ranking')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on),
                title: Text('Earnings')
            )
          ],

          currentIndex: _selectedIndex,
          //Currently selected index
          selectedItemColor: Colors.black,
          //Color which indicates selected icon
          onTap: _onItemTapped, //Action
        ),
      ),
    );
  }

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
          title: new Text("My Analytics"),

          content: new Text("Coming Soon ....."),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              textColor: Colors.blue,
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
          title: new Text("Savings"),

          content: new Text("Coming Soon savings....."),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              textColor: Colors.blue,
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
          title: new Text("Ranking"),

          content: new Text("Coming Soon Ranking....."),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              textColor: Colors.blue,
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
          title: new Text("Earnings"),

          content: new Text("Coming Soon Earnings....."),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              textColor: Colors.blue,
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