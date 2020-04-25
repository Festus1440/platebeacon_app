import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'main.dart';

Color mainColor = Colors.green;

class RestaurantAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                //contentPadding: EdgeInsets.only(left: 15.0, right: 5.0, top: 5.0, bottom: 10.0,),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantAccountDetails()));
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  //margin: EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    //border: Border.all(width: 0.0, color: mainColor),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/PB.jpg'),
                    ),
                  ),
                ),
                title: Text("Name of Profile"),
                subtitle: Text("View account"),
              ),
              Divider(
                height: 0.0,
                thickness: 0.5,
                color: mainColor,
                indent: 0.0,
                endIndent: 0.0,
              ),
            ],
          ),
          ListTile(
            onTap: () {
            },
            leading: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.favorite)
            ),
            title: Text("Favorites"),
          ),
          ListTile(
            onTap: () {
            },
            leading: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.help)
            ),
            title: Text("Help"),
          ),
          ListTile(
            onTap: () {
            },
            leading: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.credit_card)
            ),
            title: Text("Payment Options"),
          ),
          ListTile(
            onTap: () {
            },
            leading: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.info)
            ),
            title: Text("About"),
          ),
        ],
      ),
    );
  }
}

class RestaurantAccountDetails extends StatefulWidget {
  @override
  _RestaurantAccountDetailsState createState() => _RestaurantAccountDetailsState();
}

class _RestaurantAccountDetailsState extends State<RestaurantAccountDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 20.0,
          color: mainColor,
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        elevation: 10.0,
        title: Text("Account"),
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 170,
              width: double.infinity,
              //padding: EdgeInsets.all(20.0),
              color: mainColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 35.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/PB.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0, bottom: 5.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.info),
                  SizedBox(width: 30.0,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Restaurant Name",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, top: 10, right: 15.0, bottom: 5.0),
              //color: Colors.green,
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on),
                  SizedBox(width: 30.0,),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Street",
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "City",
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "State",
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Expanded(
                              child: TextField(
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
              padding: EdgeInsets.only(left: 15.0, top: 10, right: 15.0, bottom: 5.0),
              //color: Colors.green,
              child: Row(
                children: <Widget>[
                  Icon(Icons.email),
                  SizedBox(width: 30.0,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
              //color: Colors.green,
              child: Row(
                children: <Widget>[
                  Icon(Icons.phone),
                  SizedBox(width: 30.0,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0,),
          ],
        ),
      ),
    );
  }
}
