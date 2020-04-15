import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material",
      home: MaterialHome(),
    );
  }
}

class MaterialHome extends StatefulWidget {
  @override
  _MaterialHomeState createState() => _MaterialHomeState();
}

class _MaterialHomeState extends State<MaterialHome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final tabs = [
    Container(
      child: Column(
        children: <Widget>[
          Text("Register as a restaurant"),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Restaurant/Organization Name',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
        ],
      ),
    ),
    Container(
      child: Column(
        children: <Widget>[
          Text("Register as a shelter"),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Shelter Name',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
        ],
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: Colors.black38,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            title: Text('Restaurant'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Shelter'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Register"),
        backgroundColor: Colors.black38,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                  child: Image(
                    image: AssetImage('assets/PB.jpg'),
                    width: 190.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                tabs[_selectedIndex],
                SizedBox(height: 40.0),
                Container(
                  child: FlatButton(
                    //elevation: 0.0,
                    color: Colors.black38,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    //padding: EdgeInsets.fromLTRB(30.0, 8.0, 20.0, 8.0),
                    //splashColor: Colors.blueAccent,
                    onPressed: () {
                      //Navigator.of(context).pushReplacementNamed('/home');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Text(
                        "Create account",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
