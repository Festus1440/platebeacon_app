import 'package:flutter/material.dart';
import 'package:flutterapp/ShelterDrawer/restaurantDetails.dart';

//enum DialogAction{Yes, No}

//class Dialogs{
  //static Future<DialogAction>
//}
class AccountSettingsDetails extends StatefulWidget {
  @override
    _AccountDetailsState createState() => _AccountDetailsState();
}


class _AccountDetailsState extends State<AccountSettingsDetails> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Container(
            child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            child: Text("Change Email", style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold,),),
                            onTap: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (
                                  context) => RestaurantDetails()));
                            },
                          ),
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 3.0),
                            child: GestureDetector(
                              child: Text("Delete Account", style: TextStyle(
                                fontSize: 10.0, fontWeight: FontWeight.bold,),),
                            )
                        )
                      ],
                    ),
                  ),
                ]
            )
        )
  );
  }
}