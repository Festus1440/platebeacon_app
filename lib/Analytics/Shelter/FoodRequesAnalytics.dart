import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodRequestAnalytics extends StatefulWidget{
  @override
  _FoodRequest createState() => _FoodRequest();
}

class _FoodRequest extends State<FoodRequestAnalytics>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        heightFactor: 445,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
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
              Image(
                image: AssetImage('assets/barChart3.png'),
              )
            ],
          ),
        )
    );
  }
}