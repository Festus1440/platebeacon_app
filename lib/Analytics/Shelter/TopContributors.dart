import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopContributors extends StatefulWidget{
  @override
  _Top createState() => _Top();
}


class _Top extends State<TopContributors>{
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