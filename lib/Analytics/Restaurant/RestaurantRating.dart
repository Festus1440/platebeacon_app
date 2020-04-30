import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget{
  @override
  _RatingPageLayout createState() => _RatingPageLayout();
}


class _RatingPageLayout extends State<RatingPage>{
  @override
  Widget build(BuildContext context) {
    return  ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ListTile(
            title: Text('Ranking 1'),
          ),
          ListTile(
            title: Text('Ranking 2'),
          ),
          ListTile(
            title: Text('Ranking 3'),
          ),
          ListTile(
            title: Text('Ranking 4'),
          ),
        ],
      );
  }
}