import 'package:flutter/material.dart';
import 'main.dart';

class Restaurant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Restaurant Details"),
        backgroundColor: Colors.black38,
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: 350,
              height: 200,
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  border: Border.all(width: 2.0, color: const Color(0x000000)),
                  //shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/food.jpg'),
                  )
              ),
            ),
          ),
          Container(
            //color: Colors.black12,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 15.0, left: 14.0),
            child: Container(
                child: Stack(
                  children: <Widget>[
                    Column(
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
                            "Chicago, IL",
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
                            "Open 24 Hours",
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 7.0),
                          alignment: Alignment.topLeft,
                          child: Divider(
                            height: 15.0,
                            thickness: 0.5,
                            color: Colors.black38,
                            indent: 0.0,
                            endIndent: 20.0,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 7.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Restaurant info",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "Address: 123 Main St",
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
                            "Phone: (123)456-7890",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          )
        ],
      ),
    );
  }
}
