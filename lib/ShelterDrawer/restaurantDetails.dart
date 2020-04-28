import 'package:flutter/material.dart';

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
                    image: AssetImage('assets/food.jpg'),
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
                              "Restaurant Name",
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
                              "The Mayfair Supper Club - Bellagio ",
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
                                  "Restaurant Info",
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
                                  "Address: 3600 Las Vegas Blvd S, Las Vegas, NV 89109",
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
                                  "Phone: (702) 693-8876",
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
                                  "Number of Employee: 22",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              /*Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Volunteers Request: Receptionist",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),*/
                              /*Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(top: 3.0),
                                child: Text(
                                  "Donation Request: Foods, Beds",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),*/
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(top: 3.0),
                                child: Text(
                                  "Reviews: 4.7/5",
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
