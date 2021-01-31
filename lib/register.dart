import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:provider/provider.dart';
import 'ShelterDrawer/loading.dart';

//import 'ShelterMain.dart';

class Register extends StatelessWidget {
  get loading => bool;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : MaterialApp(
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
  bool loading = false;
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
        elevation: 10.0,
        color: mainColor,
        child: Padding(
          padding: EdgeInsets.all(20),
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
                      Expanded(
                        child: FilterChip(
                          backgroundColor: Colors.black12,
                          selectedColor: Colors.green,
                          labelStyle: TextStyle(color: Colors.black),
                          padding: EdgeInsets.all(8.0),
                          label: Row(
                            children: <Widget>[
                              Icon(Icons.restaurant),
                              Text(' Restaurant'),
                            ],
                          ),
                          selected: _isRestaurant,
                          onSelected: (selected) {
                            setState(() {
                              loading = true;
                              _isRestaurant = selected;
                              if (selected == true) {
                                setState(() {
                                  mainColor = Colors.green;
                                  _isShelter = !selected;
                                  role = "Restaurant";
                                  print(role);
                                  checkBoxLabelText =
                                  "Restaurant/Organization Name";
                                });
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: FilterChip(
                          backgroundColor: Colors.black12,
                          selectedColor: Colors.blue,
                          labelStyle: TextStyle(color: Colors.black),
                          padding: EdgeInsets.all(8.0),
                          label: Row(
                            children: <Widget>[
                              Icon(Icons.home),
                              Text(' Shelter'),
                            ],
                          ),
                          selected: _isShelter,
                          onSelected: (selected) {
                            setState(() {
                              loading = true;
                              _isShelter = selected;
                              if (selected == true) {
                                setState(() {
                                  mainColor = Colors.blue;
                                  _isRestaurant = !selected;
                                  role = "Shelter";
                                  print(role);
                                  checkBoxLabelText = "Shelter Name";
                                });
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    //margin: EdgeInsets.all(10),
                    //color: Colors.lightBlue,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.account_box,
                              color: mainColor,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                decoration: InputDecoration(
                                  labelText: checkBoxLabelText,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: mainColor),
                                  ),
                                ),
                                onChanged: (value) {
                                  this.setState(() {
                                    _name = value;
                                    if (_name == "") {
                                      showError("Name can't be empty", true);
                                      loading = false;
                                    } else {
                                      showError("", false);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.email,
                              color: mainColor,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                decoration: InputDecoration(
                                  labelText: "Email",
                                ),
                                onChanged: (value) {
                                  this.setState(() {
                                    _email = value;
                                    if (_email == "") {
                                      showError("Email can't be empty", true);
                                      loading = false;
                                    } else {
                                      showError("", false);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.lock,
                              color: mainColor,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.visiblePassword,
                                autocorrect: false,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                ),
                                onChanged: (value) {
                                  this.setState(() {
                                    _password = value;
                                    if (_password == "") {
                                      showError("Password can't be empty", true);
                                      loading = false;
                                    } else {
                                      showError("", false);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: errorVisible,
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      alignment: Alignment(-1.0, 0.0),
                      child: Text(
                        loginError,
                        style: TextStyle(
                          color: mainColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      //elevation: 10.0,
                      color: mainColor,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      //padding: EdgeInsets.fromLTRB(30.0, 8.0, 20.0, 8.0),
                      //splashColor: Colors.blueAccent,
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() => loading = false);
                        if (_email == null || _email == "") {
                          showError("Email can't be empty", true);
                        } else if (_password == null || _password == "") {
                          showError("Password can't be empty", true);
                        } else if (_name == null || _name == "") {
                          showError("Name can't be empty", true);
                        } else {
                          showError("Please wait ...", true);
                          setState(() => loading = true);
                          FirebaseAuth _auth = FirebaseAuth.instance;
                          User user = _auth.currentUser;
                          try {
                            _auth.createUserWithEmailAndPassword(
                              email: _email.trim(),
                              password: _password.trim(),
                            ).then((value) {
                              if (user != null) {
                                FirebaseFirestore.instance
                                    .collection(role)
                                    .doc(user.uid)
                                    .set({
                                  'displayName': _name,
                                  'email': _email.trim(),
                                  'role': role,
                                  'lat': 0.0,
                                  'long': 0.0,
                                  'uid': user.uid,
                                }).then((onValue) {
                                  Navigator.pop(context, role);
                                });
                              } else {
                                //showError("Error signing up", true);
                              }
                            });
                          } catch (e) {
                            showError(e.message, true);
                            print(e.toString());
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