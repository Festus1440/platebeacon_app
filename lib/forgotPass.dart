import 'package:flutter/material.dart';

import 'main.dart';

class PassRecover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/main': (BuildContext context) => MaterialDesign(),
      },
      //debugShowCheckedModeBanner: false,
      title: "Material",
      home: PassRecoverPage(),
    );
  }
}

class PassRecoverPage extends StatefulWidget {
  @override
  PassRecoverPageState createState() => PassRecoverPageState();
}

class PassRecoverPageState extends State<PassRecoverPage> {
  bool viewVisible = false;
  void showWidget() {
    setState(() {
      viewVisible = true;
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
            Visibility(
              //visible: !viewVisible,
              child: Container(
                padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Enter email or Phone No',
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: FlatButton(
                        color: Colors.black38,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        //splashColor: Colors.blueAccent,
                        onPressed: () {
                          showWidget();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Text(
                            "Continue",
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
            ),
            Visibility(
              visible: viewVisible,
              child: Container(
                padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Enter new password',
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Re-enter new password',
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: FlatButton(
                        color: Colors.black38,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        //splashColor: Colors.blueAccent,
                        onPressed: () {
                          Navigator.of(context).pop();
                          //MaterialPageRoute(builder: (context) => MaterialDesign()),);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
