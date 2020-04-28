import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'RestaurantMain.dart';
import 'ShelterMain.dart';
import 'login.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MaterialDesign());

class MaterialDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            '/login': (BuildContext context) => LoginPage(),
            '/register': (BuildContext context) => RegisterPage(),
          },
          title: "Material",
          home: userLoggedIn(),
        );
      }
  }



_goToRegister(BuildContext context) async {
  String role = await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => RegisterPage(), fullscreenDialog: true),
  );
  if (role != null) {
    await authorizeAccess(role);
    print(role);
  }
}

_goToLogin(BuildContext context) async {
  FirebaseUser role = await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => LoginPage(), fullscreenDialog: true),
  );
  if (role != null) {
    //print(role.displayName);
    //authorizeAccess(role);
  }
}

authorizeAccess(role) {
  FirebaseAuth.instance.currentUser().then((user) {
    UserUpdateInfo updateUser = UserUpdateInfo();
    updateUser.displayName = role;
    user.updateProfile(updateUser);
    //print(user.displayName);
  });
}

Widget userLoggedIn() {
  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      //print(snapshot.data);
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          body: Center(child: Text("Please wait...")),
        );
      } else {
        if (snapshot.hasData) {
          //logged in
          return FutureBuilder(
              future: FirebaseAuth.instance.currentUser(),
              builder: (BuildContext context, AsyncSnapshot user) {
                //print(user.data);
                if (user.connectionState == ConnectionState.waiting) {
                  return Scaffold(body: Center(child: Text("Please wait...")));
                } else {
                  if (user.data.displayName == "Shelter") {
                    return ShelterMain();
                  } else if (user.data.displayName == "Restaurant") {
                    return RestaurantMain();
                  } else {
                    return userLoggedIn();
                  }
                }
              });
        } else {
          return MaterialHome(); //go to home
        }
      }
    },
  );
}

class MaterialHome extends StatefulWidget {
  @override
  _MaterialHomeState createState() => _MaterialHomeState();
}

class _MaterialHomeState extends State<MaterialHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 20.0,
          color: Colors.black38,
        ),
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
                    child: Image(
                      image: AssetImage('assets/PB.jpg'),
                      width: 190.0,
                    ),
                  ),
                ],
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
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true),);
                        //Navigator.of(context).pushNamed('/login');
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
