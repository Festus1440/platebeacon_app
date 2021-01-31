import 'package:flutter/material.dart';

Color mainColor = Colors.green;

class ShelterDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Shelter Details"),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: BottomAppBar(
        color: mainColor,
        child: Padding(
          padding: EdgeInsets.all(20),
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              //width: 350,
              height: 200,
              //margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(6.0)),
                //border: Border.all(width: 1.0, color: mainColor),
                //shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/shelter.jpg'),
                  )),
            ),
          ),
         Container(
            //color: Colors.black12,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Shelter Name",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "A Harvest Shelter",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 20.0,
                      thickness: 0.5,
                      color: mainColor,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 0.0, left: 15.0, right: 15.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Open Hours",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Open 24 Hours",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 20.0,
                      thickness: 0.5,
                      color: mainColor,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),

                    Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 0.0, left: 15.0, right: 15.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Shelter Info",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Address: 123 Main St,Chicago, IL",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Phone: (123)-456-7890",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Number of People: 22",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Volunteers Request: Receptionist",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 3.0),
                            child: Text(
                              "Donation Request: Foods, Beds",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 3.0),
                            child: Text(
                              "Description: Provides Food, Shelter",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(
                      height: 20.0,
                      thickness: 0.5,
                      color: mainColor,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),

                  ],
                ),
              ],
            ),
              ]
            )
          ),
        ],
      ),
    );
  }
}
