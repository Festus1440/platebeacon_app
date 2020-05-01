import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

Color mainColor = Colors.blue;

class RestaurantDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Restaurant Details"),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 20.0,
          color: mainColor,
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
                    image: AssetImage('assets/californiaPizza.jpeg'),
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
                      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0, bottom: 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "California Pizza Kitchen",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(bottom: 10.0, top: 5.0),
                            child: Text(
                              "California Pizza Kitchen is a casual dining restaurant chain that specializes in California-style pizza. ",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            //padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Open until 8 PM",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  '2.6 miles away'
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              '847-897-5106'
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Hours: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        'Monday '
                                    ),
                                    Text(
                                        '11AM-8PM'
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Opacity(
                                      opacity: 0.0,
                                      child: Text(
                                          'Hours: '
                                      ),
                                    ),
                                    Text(
                                        'Tuesday '
                                    ),
                                    Text(
                                      '11AM-8PM'
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Opacity(
                                      opacity: 0.0,
                                      child: Text(
                                          'Hours: '
                                      ),
                                    ),
                                    Text(
                                        'Wednesday '
                                    ),
                                    Text(
                                        '11AM-8PM'
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Opacity(
                                      opacity: 0.0,
                                      child: Text(
                                          'Hours: '
                                      ),
                                    ),
                                    Text(
                                        'Thursday '
                                    ),
                                    Text(
                                        '11AM-8PM'
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Opacity(
                                      opacity: 0.0,
                                      child: Text(
                                          'Hours: '
                                      ),
                                    ),
                                    Text(
                                        'Friday '
                                    ),
                                    Text(
                                        '11AM-8PM'
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Opacity(
                                      opacity: 0.0,
                                      child: Text(
                                          'Hours: '
                                      ),
                                    ),
                                    Text(
                                        'Saturday '
                                    ),
                                    Text(
                                        '11AM-8PM'
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Opacity(
                                      opacity: 0.0,
                                      child: Text(
                                          'Hours: '
                                      ),
                                    ),
                                    Text(
                                        'Sunday '
                                    ),
                                    Text(
                                        '11AM-8PM'
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}