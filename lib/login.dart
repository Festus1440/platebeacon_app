import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ShelterDrawer/loading.dart';
import 'forgotPass.dart';
import 'register.dart';
import 'ShelterMain.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatelessWidget {
  get loading => false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: <String, WidgetBuilder>{
              '/register': (BuildContext context) => RegisterPage(),
              '/shelterMain': (BuildContext context) => ShelterMain(),
              '/recoverPass': (BuildContext context) => PassRecover()
            },
            title: "Log in",
            home: LoginPage(),
          );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
  bool loading = false;
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  String _email, _password;
  bool errorVisible = false;
  String loginError = "";
  void showError(error, show) {
    setState(() {
      loginError = error;
      errorVisible = show;
    });
  }

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
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Log in"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
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
              padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.green,
                    ),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                      onChanged: (value) {
                        this.setState(() {
                          _email = value;
                          if (_email == "") {
                            showError("Email can't be empty", true);
                          } else {
                            showError("", false);
                          }
                        });
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.lock,
                      color: Colors.green,
                    ),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        this.setState(() {
                          _password = value;
                          if (_password == "") {
                            showError("Password can't be empty", true);
                          } else {
                            showError("", false);
                          }
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 15.0),
                    child: InkWell(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PassRecoverPage(),
                                fullscreenDialog: true),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Colors.green,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      //splashColor: Colors.blueAccent,
                      onPressed: () {
                        setState(() => loading = true);
                        if (_email == null || _email == "") {
                          showError("Email can't be empty", true);
                        } else if (_password == null || _password == "") {
                          showError("Password can't be empty", true);
                        } else {
                          showError("", false);
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email, password: _password)
                              .then((value) {
                            Navigator.pop(context, value.user);
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => ShelterMain(), fullscreenDialog: true),);
                            //Navigator.of(context).pop();
                          }).catchError((error) {
                            showError(error.message, true);
                            print("Error: " + error.message);
                          });
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShelterMain()),);
                          //Navigator.of(context).pushReplacementNamed('shelterMain');
                        }
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
                  Visibility(
                    visible: errorVisible,
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      alignment: Alignment(-1.0, 0.0),
                      child: Text(loginError),
                    ),
                  ),
                  //SizedBox(height: 30.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
