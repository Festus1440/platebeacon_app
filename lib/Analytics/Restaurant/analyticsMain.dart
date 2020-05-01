import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Analytics/Restaurant/GraphRestaurant.dart';
import 'package:flutterapp/Analytics/Shelter/FoodDonationsAnalytics.dart';
import 'package:flutterapp/Analytics/Shelter/ShelterHomeAnalytics.dart';
import 'package:flutterapp/Analytics/Shelter/TopContributors.dart';

import 'EarningsRestaurant.dart';
import 'RestaurantRating.dart';
import 'SavingRestaurant.dart';

class AnalyticsMain extends StatefulWidget{
  @override
  _AnalyticsMainState createState() => _AnalyticsMainState();
}

class _AnalyticsMainState extends State<AnalyticsMain> {
  int _currentIndex = 0;
  final bottomBarItems = [
    AnalyticsHomePage(),
    RatingPage(),
    AnalyticsHomePage(),
  ];

  void _onItemTapped(int index) {
    print(_currentIndex);
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Analytics"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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
      body: bottomBarItems[_currentIndex],
    );
  }
}