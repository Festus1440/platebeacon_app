import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//import 'package:flutterapp/restaurantBottomBar/pickup.dart';

Widget whatUser() {
  //logged in
  return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot user) {
        //print(user.data);
        if (user.connectionState == ConnectionState.waiting) {
          return Center(child: Text("Please wait..."));
        } else {
          if (user.data.displayName == "Shelter") {
            return ShelterHome();
          } else if (user.data.displayName == "Restaurant") {
            return RestaurantHome();
          } else {
            return Error();
          }
        }
      });
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 250,
            //margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            decoration: BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(6.0)),
                //border: Border.all(width: 1.0, color: mainColor),
                //shape: BoxShape.circle,
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/food.jpg'),
            )),
          ),
          Container(
            //color: Colors.green,
            height: MediaQuery.of(context).size.height * 0.42,
            width: MediaQuery.of(context).size.width,
            child: whatUser(),
          ),
        ],
      ),
    );
  }
}

class RestaurantHome extends StatefulWidget {
  @override
  _RestaurantHomeState createState() => _RestaurantHomeState();
}

var _controller = TextEditingController();
Color mainColor = Colors.green;
String mainCollection = "";
String subCollection = "";
String userId = "";

class _RestaurantHomeState extends State<RestaurantHome> {
  bool showModal = false;
  var selectedId;
  int pickSize = 0;
  int donSize = 0;
  DateTime _dateTime;
  TimeOfDay _timeOfDay = TimeOfDay.now();
  String selectedDate = "";
  String selectedTime = "";
  int id = 0;
  var hintText = TextEditingController();
  String selectedHint;
  String name = "";
  String formattedTimeOfDay;
  String from;
  int date = 0;
  String error;
  // TimeOfDay res = TimeOfDay.fromDateTime(DateTime.now());
  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      if (user.displayName == "Shelter") {
        if (!mounted) return;
        setState(() {
          userId = user.uid;
          mainCollection = "Shelter";
          subCollection = "pickup";
          mainColor = Colors.blue;
        });
      } else {
        if (!mounted) return;
        setState(() {
          userId = user.uid;
          mainCollection = "Restaurant";
          subCollection = "donations";
          mainColor = Colors.green;
        });
        Firestore.instance
            .collection("Restaurant")
            .document(userId)
            .get()
            .then((DocumentSnapshot data) {
          setState(() {
            from = data.data['displayName'] ?? "null";
          });
        });
        countDonations();
      }
    });
  }

  void countDonations() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection("Restaurant")
        .document(userId)
        .collection("donations")
        .getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    //print(_myDocCount.length);
    if (!mounted) return;
    setState(() {
      donSize = _myDocCount.length;
    });
  }

  void countPickups(userId) async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection("Shelter")
        .document(userId)
        .collection("pickup")
        .getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    print(_myDocCount.length);
    if (!mounted) return;
    setState(() {
      pickSize = _myDocCount.length;
    });
  }

  update() {
    Firestore.instance
        .collection("Restaurant")
        .document(userId)
        .collection("donations")
        .document()
        .setData({
      'date': selectedDate + selectedTime,
      "id": date,
      "from": from,
      "to": selectedHint,
      "name": name,
    }).then((onValue) {
      Firestore.instance
          .collection("Shelter")
          .document(selectedId)
          .collection("pickup")
          .document()
          .setData({
        'date': selectedDate + selectedTime,
        "id": date,
        "from": from,
        "to": selectedHint,
        "name": name,
      }).then((onValue) {});
    });
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (picked != null) {
      print(_timeOfDay);
      if (!mounted)
        return; // make sure not to run if its not mounted aka available saves memory
      setState(() {
        _timeOfDay = picked;
      });
      final MaterialLocalizations localizations =
          MaterialLocalizations.of(context);
      String formattedTimeOfDay = localizations.formatTimeOfDay(_timeOfDay);
      print(formattedTimeOfDay);
      selectedTime = " at " + formattedTimeOfDay;
    }
    setState(() {
      hintText.text = selectedDate + selectedTime;
      date = int.parse(selectedDate.replaceAll("/", ""));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: !showModal,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                  leading: Icon(Icons.menu),
                  title: Container(
                    margin: EdgeInsets.only(left: 0),
                    child: TextField(
                      enabled: false,
                      controller: _controller,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => _controller.clear(),
                          icon: Icon(Icons.close),
                        ),
                        hintText: "Location",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                child: ListTile(
                  onTap: () {
                    setState(() {
                      showModal = true;
                    });
                  },
                  contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                  leading: Icon(Icons.calendar_today),
                  title: Container(
                    margin: EdgeInsets.only(
                      left: 0,
                    ),
                    child: Text("Schedule Donation",style: TextStyle(fontFamily: "SF"),),
                  ), //
                ),
              ),
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                  leading: Container(
                    height: 50,
                    child: Text(
                      "",
                    ),
                  ),
                  title: Container(
                      margin: EdgeInsets.only(left: 0),
                      child: Text("Next Donation")),
                  subtitle: Container(
                    margin: EdgeInsets.only(left: 0),
                    child: fetch("No Scheduled Donations"),
                  ),
                  //trailing:
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: showModal,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              //color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        //color: mainColor,
                        child: IconButton(
                          splashColor: mainColor,
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              showModal = false;
                            });
                          },
                        ),
                        //height: 50,
                        //width: 50,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 30.0, right: 30),
                          //margin: EdgeInsets.only(top: 0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: error ?? "Title",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    name = value;
                                  });
                                },
                              ),

                              StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection("Shelter")
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CupertinoActivityIndicator(),
                                      );
                                    } else {
                                      return InkWell(
                                        onTap: () {},
                                        child: DropdownButton(
                                          isExpanded: true,
                                          itemHeight: 60,
                                          hint: Text(
                                              selectedHint ?? "Choose a Shelter"),
                                          items: snapshot.data.documents
                                              .map((DocumentSnapshot document) {
                                            return DropdownMenuItem<String>(
                                              value: document.documentID,
                                              child:
                                                  Text(document.data['displayName']),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            Firestore.instance
                                                .collection("Shelter")
                                                .document(value)
                                                .get()
                                                .then((DocumentSnapshot data) {
                                              setState(() {
                                                selectedId = value;
                                                selectedHint =
                                                    data.data['displayName'] ??
                                                        "error";
                                                print(
                                                    selectedId + " " + selectedHint);
                                              });
                                            });
                                            //countPickups(value);
                                          },
                                        ),
                                      );
                                    }
                                  }),
                              Stack(
                                children: <Widget>[
                                  TextField(
                                    keyboardType: TextInputType.datetime,
                                    onTap: () {},
                                    enabled: false,
                                    controller: hintText,
                                    decoration: InputDecoration(
                                      hintText: "Date & Time is required",
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Icon(Icons.calendar_today),
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                helpText: "",
                                                initialDate: _dateTime == null
                                                    ? DateTime.now()
                                                    : _dateTime,
                                                firstDate: DateTime(2019),
                                                lastDate: DateTime(2222))
                                            .then((date) {
                                          if (!mounted)
                                            return; // make sure not to run if its not mounted aka available saves memory
                                          setState(() {
                                            if (date != null) {
                                              _dateTime = date;
                                              selectedDate = date.month.toString() +
                                                  "/" +
                                                  date.day.toString() +
                                                  "/" +
                                                  date.year.toString();
                                              selectTime(context);
                                            }
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15, bottom: 20),
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                child: FlatButton(
                                  color: mainColor,
                                  onPressed: () {
                                    if (selectedDate == null ||
                                        selectedDate == "" ||
                                        selectedId == null ||
                                        selectedId == "" ||
                                        name == null ||
                                        name == "") {
                                      setState(() {
                                        error = "Title is required";
                                      });
                                      print("missing Fields");
                                    } else {
                                      update();
                                      setState(() {
                                        showModal = false;
                                      });
                                    }
                                  },
                                  child: Text("Donate"),
                                ),
                              ),
                              Container(
                                color: Colors.blue,
                                height: MediaQuery.of(context).viewInsets.bottom,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget fetch(message) {
  if (mainCollection == "" || mainCollection == null) {
    return Text("Please wait");
  } else {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(mainCollection)
          .document(userId)
          .collection(subCollection)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.documents.length <= 0) {
            return Text(message);
          } else {
            var data = snapshot.data.documents.first['date'];
            if (data == null) {
              data = message;
              return Text(data.toString());
            } else {
              return Text(data.toString());
            }
          }
        } else {
          return Text('Checking...');
        }
      },
    );
  }
}

class ShelterHome extends StatefulWidget {
  @override
  _ShelterHomeState createState() => _ShelterHomeState();
}

class _ShelterHomeState extends State<ShelterHome> {
  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      if (user.displayName == "Shelter") {
        if (!mounted) return;
        setState(() {
          userId = user.uid;
          mainCollection = "Shelter";
          subCollection = "pickup";
          mainColor = Colors.blue;
        });
      } else {
        if (!mounted) return;
        setState(() {
          userId = user.uid;
          mainCollection = "Restaurant";
          subCollection = "donations";
          mainColor = Colors.green;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          child: ListTile(
            enabled: false,
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.menu),
            title: Text("Location"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.close),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          child: ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15)),
                    backgroundColor: Colors.white,
                    title: new Text("Food request coming soon!"),
                    content: new Text(
                        "Getting too many potatoes? Let's go ahead and share that information so we "
                        "can share the wealth elsewhere, and ensure you get the food you need! This will also "
                        "provide much needed data to see what foods are scarce, compared to whats easily accessable. "),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Sounds good!"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.restaurant),
            title: Text("Request Food"),
          ),
        ),
        Container(
          child: ListTile(
            //onTap: (){},
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Container(height: 50, child: Text("")),
            title: Text("Next Pickup"),
            subtitle: fetch("No Available Pickups"),
          ),
        ),
      ],
    );
  }
}

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Error");
  }
}
