import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:provider/provider.dart';

import 'main.dart';

//Reset Password
final _firebaseAuth = FirebaseAuth.instance;

Future sendPasswordResetEmail(String email) async {
  return _firebaseAuth.sendPasswordResetEmail(email: email);
}
/*
class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}
*/

bool validate() {
  var formKey;
  final form = formKey.currentState;
  form.save();
  if (form.validate()) {
    form.save();
    return true;
  } else {
    return false;
  }
}

class PassRecover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/main': (BuildContext context) => MainPage(),
      },
      //debugShowCheckedModeBanner: false,
      title: "Material",
      home: PassRecoverPage(),
    );
  }
}

//enum AuthFormType { login, register, reset } //I dont knw hwy I made this

class PassRecoverPage extends StatefulWidget {
  //final AuthFormType authFormType;
  //PassRecoverPage({Key key, @required this.authFormType}) : super(key: key);
  @override
  _PassRecoverPageState createState() =>
      _PassRecoverPageState(); //authFormType: this.authFormType
} //PassRecoverPage ends here

class _PassRecoverPageState extends State<PassRecoverPage> {
  //AuthFormType authFormType;
  _PassRecoverPageState(); //{this.authFormType}

  //final formKey = GlobalKey<FormState>();

  String _email, warning = "";

  bool viewVisible = false;
  bool errorVisible = false;
  void showError(error, show) {
    setState(() {
      warning = error;
      errorVisible = show;
    });
  }

  get child => null;
  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

/*
  void save() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;

        if (authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          print("password reset email sent");
        }
      } catch (e) {
        print(e);
        setState(() {
          warning = "A password reset link has been sent to $_email";
          setState(() {
            authFormType = AuthFormType.login;
          });
        });
      }
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        child: Padding(
          padding: EdgeInsets.all(20),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Account Recovery"),
        backgroundColor: Colors.black38,
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
                  TextField(
                    onChanged: (value) {
                      this.setState(() {
                        _email = value;
                        if (_email == "" || _email == null) {
                          print("Empty");
                          showError("Email can't be empty", true);
                        } else {
                          showError("", false);
                        }
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter email or Phone No',
                        labelStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                  Visibility(
                    visible: errorVisible,
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      alignment: Alignment(-1.0, 0.0),
                      child: Text(warning),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Builder(
                      builder: (context) =>
                        FlatButton(
                          color: Colors.black38,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          //splashColor: Colors.blueAccent,
                          onPressed: () {
                            setState(() {});
                            if (_email == "" || _email == null) {
                              showError("Email can't be empty", true);
                            } else {
                              showError("", false);
                              FirebaseAuth.instance.sendPasswordResetEmail(email: _email).then((value) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Password reset email sent successful'),
                                  duration: Duration(seconds: 3),
                                ));
                              }).catchError((error) {
                                showError(error.message, true);
                                print("Error: " + error.message);
                              });
                            }
                            //showWidget();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
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
    );
  }
}
