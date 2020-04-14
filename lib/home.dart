import 'package:flutter/material.dart';
import 'main_drawer.dart';

class LoginHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _MaterialHomeState createState() => _MaterialHomeState();
}

class _MaterialHomeState extends State<Home> {
  String shelterName = 'Shelter Name';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 20.0,
            color: Colors.black38,
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
          title: Text(shelterName),
          backgroundColor: Colors.black38,
        ),
        drawer: MenuDrawer());
  }
}
