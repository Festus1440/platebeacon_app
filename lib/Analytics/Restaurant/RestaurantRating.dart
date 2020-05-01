import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantRating extends StatefulWidget{
  @override
  _Top createState() => _Top();
}


class _Top extends State<RestaurantRating>{

  //Creates the elements
  List<String> getListElements() {
    var items = List<String>.generate(15, (counter) => "Item $counter");
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
            title: Text("#$index Restaurant" ,    //Default for demostration
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
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomLeft,
          child: Text('Your Ranking is:',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 30,
            ),),
        ),
        Expanded(
            child: getListView()),
      ],
    );
  }
}