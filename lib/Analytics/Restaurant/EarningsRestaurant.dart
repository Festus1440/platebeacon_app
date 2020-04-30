import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EarningsTotal extends StatefulWidget{
  @override
  _SavingTotalPage createState() => _SavingTotalPage();
}

class _SavingTotalPage extends State<EarningsTotal>{

//  int number = 0;
//  void addNumbers() {
//    setState(() {
//      number = number + 1;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Savings',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                  ),),
                height: 40,
              ),
//              new Text(
//                '$number',
//                style: new TextStyle(
//                  fontWeight: FontWeight.bold,
//                  fontSize: 15.0,
//                  fontFamily: 'Roboto',
//                ),
//              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Week'),
                    onPressed: null,
                    color: Colors.green,
                  ),
                  RaisedButton(
                    child: Text('Month'),
                    onPressed: null,
                  ),
                  RaisedButton(
                    child: Text('Year'),
                    onPressed: null,
                  ),
//                  new RaisedButton(
//                    padding: const EdgeInsets.all(8.0),
//                    textColor: Colors.white,
//                    color: Colors.blue,
//                    onPressed: addNumbers,
//                    child: new Text("Add"),)
                ],
              ),
              Image(
                image: AssetImage('assets/barChart3.png'),
              )
            ],
        )
    );
  }
}