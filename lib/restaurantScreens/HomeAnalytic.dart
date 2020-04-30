import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutterapp/restaurantScreens/AnalyticsPage.dart';
import 'package:flutterapp/restaurantScreens/RestaurantRating.dart';
import 'package:flutterapp/restaurantScreens/Earning.dart';

class AnalyticsHomePage extends StatefulWidget{
  @override
  _HomePageAnalytics createState() => _HomePageAnalytics();
 }

class _HomePageAnalytics extends State<AnalyticsHomePage>{
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
}