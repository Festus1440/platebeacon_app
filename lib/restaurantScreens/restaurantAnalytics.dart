//Implementation by Jose Heras on 04/27/2020

import 'package:flutter/material.dart';

class RestaurantAnalytics extends StatelessWidget{
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

class _AnalyticsBodyState extends State<AnalyticsBody>{
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
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  //Builds the overall view of the Analytics page
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(                 //Top Bar.
          backgroundColor: Colors.green,
          title: Text("My Analytics"),
        ),
        body: Center(                   //Body of the screen
          child: _widgetOptions.elementAt(_selectedIndex),
          ),
        bottomNavigationBar: BottomNavigationBar(   //Lower navigation.
          backgroundColor: Colors.grey,
          items: const <BottomNavigationBarItem>[   //Contains the lower icons on the screen
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

          currentIndex: _selectedIndex,       //Currently selected index
          selectedItemColor: Colors.black,    //Color which indicates selected icon
          onTap: _onItemTapped,               //Action
        ),
      ),
    );
  }
}