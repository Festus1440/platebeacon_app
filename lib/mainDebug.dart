import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/RestaurantMain.dart';
import 'package:flutterapp/ShelterMain.dart';
import 'package:flutterapp/register.dart';

import 'login.dart';

class DetermineUser extends StatefulWidget {
  @override
  _DetermineUserState createState() => _DetermineUserState();
}

class _DetermineUserState extends State<DetermineUser> {
  @override
  Widget build(BuildContext context) {

  }
}


class debugNotLoggedInPage extends StatefulWidget {
  @override
  _debugNotLoggedInPageState createState() => _debugNotLoggedInPageState();
}

class _debugNotLoggedInPageState extends State<debugNotLoggedInPage> {
  var current = debugNotLoggedInPage();
  _goToRegister(BuildContext context) async {
    final role = await Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => RegisterPage(), fullscreenDialog: true),
    );
    if (role != null) {
      //authorizeAccess(role);
      print("role ${role}");
    }
    //DetermineUser(role);
  }
  DetermineUser(role){
    if (role == null){
      return debugNotLoggedInPage();
    }
    else if (role == "Shelter") {
      return ShelterMain();
    }
    else if (role == "Restaurant") {
      return RestaurantMain();
    }
    return debugNotLoggedInPage();
  }
  _goToLogin(BuildContext context) async {
    final role = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => LoginPage(),
        fullscreenDialog: true),
    );
    if (role != null) {
      print("role ${role}");
    }
    setState(() {

    });
    //DetermineUser(role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
                child: Image(
                  image: AssetImage('assets/PB.jpg'),
                  width: 190.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 80.0),
                  Container(
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),


                      color: Colors.green,
                      textColor: Colors.white,

                      disabledTextColor: Colors.black,
                      //splashColor: Colors.blueAccent,
                      onPressed: () async {
                        _goToLogin(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),

                  Container(
                    child: OutlineButton(
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      //color: Colors.green,
                      //textColor: Colors.white,
                      borderSide: BorderSide(
                        color: Colors.green,
                        style: BorderStyle.solid,
                        width: 0.8,
                      ),

                      disabledTextColor: Colors.black,
                      //splashColor: Colors.blueAccent,
                      onPressed: () async {
                        _goToRegister(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}