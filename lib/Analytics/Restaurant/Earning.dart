import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EarningsTotal extends StatefulWidget{
  @override
  _SavingTotalPage createState() => _SavingTotalPage();
}

class _SavingTotalPage extends State<EarningsTotal>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Container(
          child: Column(
            children: <Widget>[
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