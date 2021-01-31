import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'RestaurantMain.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ShelterMain.dart';
import 'login.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:provider/provider.dart';

void main() => runApp(MainPage());
String MROLE;
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //FirebaseUser currentUser;
  
  @override
  void initState(){
    super.initState();
    //getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SF'),
      debugShowCheckedModeBanner: false,
      title: "Plate Beacon",
      home: DetermineUser()
    );
  }
}

_goToPage(BuildContext context, Page) async {
  final role = await Navigator.push(context,
    MaterialPageRoute(
        builder: (context) => Page(), fullscreenDialog: true),
  );
  if (role != null) {
    print(role);
    MROLE = role;
  }
  return role;
}


class NotLoggedInPage extends StatefulWidget {
  @override
  _NotLoggedInPageState createState() => _NotLoggedInPageState();
}

class _NotLoggedInPageState extends State<NotLoggedInPage> {
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
                        _goToPage(context, LoginPage());
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
                        _goToPage(context, RegisterPage());
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

class DetermineUser extends StatefulWidget {
  @override
  _DetermineUserState createState() => _DetermineUserState();
}

class _DetermineUserState extends State<DetermineUser> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp();
    assert(app != null);
    print('Initialized default app $app');
  }

  Future<String> userLoggedIn() async{
    String r =  MROLE;
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeDefault(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("error ${snapshot.error}"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return FutureBuilder(
            future: userLoggedIn(),
            builder: (context, snapshot){
              if(snapshot.hasError){
                return Text("error ${snapshot.error}");
              }
              if(snapshot.hasData){
                return Text("user has Data ${snapshot.data.toString()}");
              }
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CupertinoActivityIndicator(),
        );
      }
    );
  }
}