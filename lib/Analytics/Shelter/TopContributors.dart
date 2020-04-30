import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopContributors extends StatefulWidget{
  @override
  _Top createState() => _Top();
}


class _Top extends State<TopContributors>{

  //Creates the elements
  List<String> getListElements() {
    var items = List<String>.generate(40, (counter) => "Item $counter");
    return items;
  }

  //Builds the list view
  Widget getListView(){
    var listItems = getListElements();

    var listView = ListView.builder(
        itemCount: listItems.length,
        itemBuilder: (context, index){

          return ListTile(
            leading: Icon(Icons.flag),
            title: Text("Restaurant" ,    //Default for demostration
            style: TextStyle(             //Will display data from firebase
              fontSize: 30,
              fontStyle: FontStyle.italic,
              color: Colors.green
              ),
            ),
          );
        }
    );
    return listView;
  }


  @override
  Widget build(BuildContext context) {
//    return  ListView(
////      padding: ,
//      scrollDirection: Axis.vertical,
//      children: <Widget>[
//        ListTile(
//          title: Text('Ranking 1'),
//        ),
//        ListTile(
//          title: Text('Ranking 2'),
//        ),
//        ListTile(
//          title: Text('Ranking 3'),
//        ),
//        ListTile(
//          title: Text('Ranking 4'),
//        ),
//      ],
//    );
    return getListView();
  }
}