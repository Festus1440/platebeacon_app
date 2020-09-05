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
}

class _LoginPageState extends State<LoginPage> {
  bool _obscure = true;
  bool loginVisible = false;
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
        elevation: 10.0,
        child: Container(
          height: 20.0,
          color: Colors.green,
        ),
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10.0,
        title: Text("Log in"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: ListView(
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          autocorrect: false,
                          //autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          enabled: !loginVisible,
                          decoration: InputDecoration(
                            labelText: "Email",
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
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                          enabled: !loginVisible,
                          decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: (){
                                setState(() {
                                  _obscure = !_obscure;
                                });
                              },
                            ),
                          ),
                          obscureText: _obscure,
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
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Visibility(
                    visible: errorVisible,
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      alignment: Alignment(-1.0, 0.0),
                      child: Text(loginError),
                    ),
                  ),
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
                    child: Stack(
                      children: <Widget>[
                        Visibility(
                          visible: loginVisible,
                          child: Container(
                              margin: EdgeInsets.only(top: 25),
                              alignment: Alignment.center,
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator()),
                        ),
                        Visibility(
                          visible: !loginVisible,
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.green,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            //splashColor: Colors.blueAccent,
                            onPressed: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              setState(() {
                                loading = true;
                              });
                              if (_email == null || _email == "") {
                                showError("Email can't be empty", true);
                              } else if (_password == null || _password == "") {
                                showError("Password can't be empty", true);
                              } else {
                                showError("", false);
                                setState(() {
                                  loginVisible = true;
                                });
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _email.trim(),
                                        password: _password.trim())
                                    .then((value) {
                                  FirebaseAuth.instance.currentUser().then((value) {
                                    Navigator.pop(context, value.displayName);
                                  });
                                }).catchError((error) {
                                  setState(() {
                                    loginVisible = false;
                                  });
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              //color: Colors.blue,
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
