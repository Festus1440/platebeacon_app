import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget{
  @override
  _RatingPageLayout createState() => _RatingPageLayout();
}


class _RatingPageLayout extends State<RatingPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  ListView(
        children: <Widget>[
          Container(
            child: Text('Hello'),
            width: 800,
            color: Colors.blue,
          ),
          Text('Rating 2'),
          Text('Rating 3'),
          Text('Rating 4'),
        ],
      );
  }
}