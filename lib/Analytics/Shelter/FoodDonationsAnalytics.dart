import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodDonationsAnalytics extends StatefulWidget{
  @override
  _FoodDonations createState() => _FoodDonations();
}

class _FoodDonations extends State<FoodDonationsAnalytics>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        heightFactor: 445,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Text('Food Request',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                ),),
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Week'),
                    onPressed: null,
                  ),
                  RaisedButton(
                    child: Text('Month'),
                    onPressed: null,
                  ),
                  RaisedButton(
                    child: Text('Year'),
                    onPressed: null,
                  )
                ],
              ),
              Container(
                height: 40,
              ),
              Image(
                image: AssetImage('assets/barChart3.png'),
              )
            ],
          ),
        )
    );
  }
}