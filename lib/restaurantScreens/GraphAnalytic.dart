import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Saving {
  int amount;
  String bottom;
  charts.Color barColor;

  Saving({
    @required this.amount,
    @required this.bottom,
    @required this.barColor});

  Saving.fromMap(Map<String, dynamic> map)
   :assert(map['amount'] != null),
    assert(map['bottom'] != null),
    assert(map['barColor'] != null),
      amount = map['amount'],
      bottom = map['bottom'],
      barColor = map['barColor'];
}

//final list<Saving> data = [
//  Saving(
//    amount: 11,
//    bottom: 'Monday',
//    barColor: charts.ColorUtil.fromDartColor(Colors.black)
//  ),
//  Saving(
//    amount: 15,
//    bottom: 'Tuesday',
//    barColor: charts.ColorUtil.fromDartColor(Colors.black)
//  )
//];