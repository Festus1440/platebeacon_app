import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'main.dart';

Color mainColor;

class EditAccountDetails extends StatefulWidget {
  final String type;
  EditAccountDetails(this.type);

  @override
  _EditAccountDetailsState createState() =>
      _EditAccountDetailsState();
}

class _EditAccountDetailsState extends State<EditAccountDetails> {
  String userId = "";
  var personName = TextEditingController();
  var email = TextEditingController();
  var role = TextEditingController();
  var street = TextEditingController();
  var city = TextEditingController();
  var state = TextEditingController();
  var zip = TextEditingController();
  var phone = TextEditingController();
  String citySearch = "";
  String streetSearch = "";
  String collection = "";
  bool loading = true;
  Map dataread;

  Future<String> _getDataFromSharedPref(key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data == null){
      return null;
    }
    return data;
  }

  Future<void> _setSharedPref(key, String) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, String);
  }

  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
    _getDataFromSharedPref(userId).then((value) {
      if (value != null){
        Map data = jsonDecode(value);
        if (!mounted) return;
        setState(() {
          loading = false;
          personName.text = data["displayName"] ?? "";
          email.text = data["email"] ?? "";
          role.text = data["role"] ?? "";
          street.text = data["street"] ?? "";
          streetSearch = data["street"] ?? "";
          city.text = data["city"] ?? "";
          citySearch = data["city"] ?? "";
          state.text = data["state"] ?? "";
          zip.text = data["zip"] ?? "";
          phone.text = data["phone"] ?? "";
        });
      }
      else {
        getData(userId);
      }
    });
    setState(() {
      if (widget.type == "Shelter") {
        collection = "Shelter";
        mainColor = Colors.blue;
      } else {
        collection = "Restaurant";
        mainColor = Colors.green;
      }
    });
  }

  getData(id) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .get()
        .then((DocumentSnapshot data) {
      setState(() {
        loading = false;
        personName.text = data["displayName"] ?? "";
        email.text = data["email"] ?? "";
        role.text = data["role"] ?? "";
        street.text = data["street"] ?? "";
        streetSearch = data["street"] ?? "";
        city.text = data["city"] ?? "";
        citySearch = data["city"] ?? "";
        state.text = data["state"] ?? "";
        zip.text = data["zip"] ?? "";
        phone.text = data["phone"] ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: mainColor,
        child: Padding(
          padding: EdgeInsets.all(20),
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        elevation: 10.0,
        title: Text("Account"),
        actions: <Widget>[
          Builder(
            builder: (context) => CupertinoButton(
              child: Text("Save", style: TextStyle(color: Colors.white),),
              onPressed: () {
                FocusScope.of(context)
                    .requestFocus(new FocusNode());
                setState(() {
                  loading = true;
                });
                Geolocator()
                    .placemarkFromAddress(streetSearch + " " + citySearch)
                    .then((results) {
                  print(street.text.trim() + " " + city.text.trim());
                  FirebaseFirestore.instance
                      .collection(collection)
                      .doc(userId)
                      .update({
                    'displayName': personName.text.trim(),
                    'street': results[0].subThoroughfare +
                        " " +
                        results[0].thoroughfare,
                    'city': results[0].locality,
                    'state': results[0].administrativeArea,
                    'zip': results[0].postalCode,
                    'lat': results[0].position.latitude,
                    'long': results[0].position.longitude,
                    'email': email.text.trim(),
                    'phone': phone.text.trim(),
                  }).then((value) {
                    String data = json.encode({'displayName': personName.text.trim(),
                      'street': results[0].subThoroughfare +
                          " " +
                          results[0].thoroughfare,
                      'city': results[0].locality,
                      'state': results[0].administrativeArea,
                      'zip': results[0].postalCode,
                      'lat': results[0].position.latitude,
                      'long': results[0].position.longitude,
                      'email': email.text.trim(),
                      'phone': phone.text.trim()});
                    _setSharedPref(userId, data);
                    setState(() {
                      loading = false;
                      street.text = results[0].subThoroughfare +
                          " " +
                          results[0].thoroughfare;
                      city.text = results[0].locality;
                      state.text = results[0].administrativeArea;
                      zip.text = results[0].postalCode;
                    });
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Saved Successfully"),
                      ),
                    );
                    //Navigator.of(context).pop();
                  });
                }).catchError((error) {
                  setState(() {
                    loading = false;
                  });
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.message),
                    ),
                  );
                  //print("Error: " +""+ error.message);
                });
              },
            ),
          ),
        ],
        backgroundColor: mainColor,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                //padding: EdgeInsets.all(20.0),
                //color: mainColor,
                child: Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.7,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          "https://media.timeout.com/images/105239239/image.jpg",
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 0.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/PB.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: 15.0, top: 15.0, right: 15.0, bottom: 5.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.info),
                          SizedBox(
                            width: 30.0,
                          ),
                          Expanded(
                            child: TextField(
                              autocorrect: true,
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                              controller: personName,
                              decoration: InputDecoration(
                                hintText: "Restaurant Name",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 15.0, top: 10, right: 15.0, bottom: 5.0),
                      //color: Colors.green,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on),
                          SizedBox(
                            width: 30.0,
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  autocorrect: false,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (_) =>
                                      FocusScope.of(context).nextFocus(),
                                  onChanged: (val){
                                    setState(() {
                                      streetSearch = val;
                                    });
                                  },
                                  controller: street,
                                  decoration: InputDecoration(
                                    hintText: "Street",
                                  ),
                                ),
                                TextField(
                                  autocorrect: true,
                                  enableSuggestions: true,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (_) =>
                                      FocusScope.of(context).nextFocus(),
                                  onChanged: (val){
                                    citySearch = val;
                                  },
                                  enabled: true,
                                  controller: city,
                                  decoration: InputDecoration(
                                    hintText: "City",
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextField(
                                        enabled: false,
                                        controller: state,
                                        decoration: InputDecoration(
                                          hintText: "State",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        enabled: false,
                                        controller: zip,
                                        decoration: InputDecoration(
                                          hintText: "Zip",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 15.0, top: 10, right: 15.0, bottom: 5.0),
                      //color: Colors.green,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.email),
                          SizedBox(
                            width: 30.0,
                          ),
                          Expanded(
                            child: TextField(
                              enableSuggestions: true,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                              controller: email,
                              decoration: InputDecoration(
                                hintText: "Email",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
                      //color: Colors.green,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.phone),
                          SizedBox(
                            width: 30.0,
                          ),
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              controller: phone,
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Visibility(
            visible: loading,
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
