import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Analytics/Restaurant/RestaurantSavingCharts.dart';
import 'package:flutterapp/Analytics/Restaurant/EarningRestaurantChart.dart';
import 'package:flutterapp/Analytics/Restaurant/RestaurantRating.dart';



class RestaurantMainAnalytics extends StatefulWidget{
  @override
  _RestaurantMainAnalyticsState createState() => _RestaurantMainAnalyticsState();
}

class _RestaurantMainAnalyticsState extends State<RestaurantMainAnalytics> {
  int _currentIndex = 0;

  final bottomBarItems = [
    RestaurantSavingCharts(),
    RestaurantRating(),
    EarningRestaurantChart(),
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