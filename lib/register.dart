import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'ShelterMain.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material",
      home: RegisterPage(),
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  String _name, _email, _password;
  bool errorVisible = false;
  String loginError = "";
  void showError(error, show) {
    setState(() {
      loginError = error;
      errorVisible = show;
    });
  }
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>():

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 20.0,
          color: Colors.black38,
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Shelter Name',
                    labelStyle: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (value) {
                    this.setState(() {
                      _name = value;
                      if (_name == "") {
                        showError("Name can't be empty", true);
                      } else {
                        showError("", false);
                      }
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (value) {
                    this.setState(() {
                      _password = value;
                      if (_password == "") {
                        showError("Email can't be empty", true);
                      } else {
                        showError("", false);
                      }
                    });
                  },
                ),
                Visibility(
                  visible: errorVisible,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    alignment: Alignment(-1.0, 0.0),
                    child: Text(loginError),
                  ),
                ),
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
                    onPressed: () async {
                      if (_email == null || _email == "") {
                        showError("Email can't be empty", true);
                      } else if (_password == null || _password == "") {
                        showError("Password can't be empty", true);
                      } else if (_name == null || _name == "") {
                        showError("Name can't be empty", true);
                      } else {
                        showError("", false);
                        FirebaseUser user;
                        try {
                          user = (await _auth.createUserWithEmailAndPassword(
                            email: _email,
                            password: _password,
                          )).user;
                          //user.sendEmailVerification();
                        } catch (e) {
                          showError(e.toString(), true);
                          print(e.toString());
                        } finally {
                          if (user != null) {
                            //showError(user.uid, true);
                            Firestore.instance
                                .collection('users')
                                .document(user.uid)
                                .setData({
                              'email': _email,
                              'displayName': _name,
                            }).then((onValue) {});
                            Navigator.of(context).pop();
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => ShelterMain(user: user), fullscreenDialog: true),);
                          } else {
                            showError("Error signing up", true);
                          }
                        }
                      }
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
