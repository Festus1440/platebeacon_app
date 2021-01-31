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
    //Timer.run(() => _showDialog());
  }

  int _currentIndex = 0;

  final bottomBarItems = [
    FoodDonationsAnalytics(),
    TopContributors(),
    FoodRequestAnalytics(),
  ];


  //Function: Takes on parameter an sets the index of the currently selected widget
  void _onItemTapped(int index) {
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
}
