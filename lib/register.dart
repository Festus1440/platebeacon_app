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
  Color mainColor = Colors.green;
  String checkBoxLabelText = "Restaurant/Organization Name";
  bool _isRestaurant = true;
  bool _isShelter = false;
  String _name, _email, _password;
  String role = "Restaurant";
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
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 20.0,
          color: mainColor,
        ),
      ),
      appBar: AppBar(
        elevation: 10.0,
        title: Text("Register"),
        backgroundColor: mainColor,
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
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      FilterChip(
                        backgroundColor: Colors.black12,
                        selectedColor: Colors.green,
                        labelStyle: TextStyle(color: Colors.black),
                        padding: EdgeInsets.all(6.0),
                        label: Row(
                          children: <Widget>[
                            Icon(Icons.restaurant),
                            Text(' Restaurant'),
                          ],
                        ),
                        selected: _isRestaurant,
                        onSelected: (selected) {
                          setState(() {
                            _isRestaurant = selected;
                            if (selected == true) {
                              setState(() {
                                mainColor = Colors.green;
                                _isShelter = !selected;
                                role = "Restaurant";
                                checkBoxLabelText =
                                "Restaurant/Organization Name";
                              });
                            }
                          });
                        },
                      ),
                      SizedBox(width: 10.0),
                      FilterChip(
                        backgroundColor: Colors.black12,
                        selectedColor: Colors.blue,
                        labelStyle: TextStyle(color: Colors.black),
                        padding: EdgeInsets.all(6.0),
                        label: Row(
                          children: <Widget>[
                            Icon(Icons.home),
                            Text(' Shelter'),
                          ],
                        ),
                        selected: _isShelter,
                        onSelected: (selected) {
                          setState(() {
                            _isShelter = selected;
                            if (selected == true) {
                              setState(() {
                                mainColor = Colors.blue;
                                _isRestaurant = !selected;
                                role = "Shelter";
                                checkBoxLabelText =
                                "Shelter Name";
                              });
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  /*Row(
                    children: <Widget>[
                      Container(
                        //color: Colors.black38,
                        child: Row(
                          children: <Widget>[
                            Text("Restaurant"),
                            Checkbox(
                              value: _isRestaurant,
                              onChanged: (val) {
                                setState(() {
                                  _isRestaurant = val;
                                  if (val == true) {
                                    setState(() {
                                      _isShelter = !val;
                                      role = "Restaurant";
                                      checkBoxLabelText =
                                          "Restaurant/Organization Name";
                                    });
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.black38,
                        child: Row(
                          children: <Widget>[
                            Text("Shelter"),
                            Checkbox(
                              value: _isShelter,
                              onChanged: (val) {
                                setState(() {
                                  _isShelter = val;
                                  if (val == true) {
                                    setState(() {
                                      _isRestaurant = !val;
                                      role = "Shelter";
                                      checkBoxLabelText = "Shelter Name";
                                    });
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),*/
                  TextField(
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                      labelText: checkBoxLabelText,
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
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
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
                          showError("Password can't be empty", true);
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
                    child: RaisedButton(
                      elevation: 10.0,
                      color: mainColor,
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
                              switch (role) {
                                case 'Shelter':
                                  Firestore.instance
                                      .collection(role)
                                      .document(user.uid)
                                      .setData({
                                    'displayName': _name,
                                    'email': _email,
                                    'role': role,
                                  }).then((onValue) {});
                                  break;
                                case 'Restaurant':
                                  Firestore.instance
                                      .collection(role)
                                      .document(user.uid)
                                      .setData({
                                    'displayName': _name,
                                    'email': _email,
                                    'role': role,
                                  }).then((onValue) {});
                                  break;
                                default:
                                  Firestore.instance
                                      .collection(role)
                                      .document(user.uid)
                                      .setData({
                                    'displayName': _name,
                                    'email': _email,
                                    'role': role,
                                  }).then((onValue) {});
                              }
                              Navigator.pop(context, role);
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
                          "Register",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
