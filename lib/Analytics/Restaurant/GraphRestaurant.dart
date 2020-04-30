import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutterapp/Analytics/Restaurant/EarningsRestaurant.dart';
import 'package:flutterapp/Analytics/Restaurant/RestaurantRating.dart';
import 'package:flutterapp/Analytics/Restaurant/SavingRestaurant.dart';
import 'dart:async';

class AnalyticsHomePage extends StatefulWidget{
  @override
  _HomePageAnalytics createState() => _HomePageAnalytics();
}

class _HomePageAnalytics extends State<AnalyticsHomePage> {
  List<charts.Series<BarChart,String>> _seriesBarChart;
  List<charts.Series<Task, String>> _seriesPieData;
  _generateData() {
    var pieData = [
      new Task('Subway', 35, Color(0xff3366cc)),
      new Task('Dominos', 8, Color(0xff990099)),
      new Task('McDonalds', 10, Color(0xff109618)),
      new Task('Vegan', 15, Color(0xffdbe199)),
      new Task('Veggie', 19, Color(0xff009900)),
      new Task('Other', 20, Color(0xffdc3912)),
    ];
    _seriesPieData.add(
      charts.Series(
        data: pieData,
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Daily Task',
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );

    var chart1 = [
      new BarChart('This week', 40, 40)
    ];
    var chart2 = [
      new BarChart('Last week', 50,50)
    ];
    var chart3 = [
      new BarChart('Two weeks ago', 35, 35)
    ];

    _seriesBarChart.add(
      charts.Series(
        domainFn: (BarChart barChart, _) =>barChart.week,
        measureFn:(BarChart barChart, _)=> barChart.quantity,
        id: '2017',
        data: chart1,
        fillPatternFn:(_,__)=>charts.FillPatternType.solid,
        fillColorFn:(BarChart barChart, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesBarChart.add(
      charts.Series(
        domainFn: (BarChart barChart, _) =>barChart.week,
        measureFn:(BarChart barChart, _)=> barChart.quantity,
        id: '2018',
        data: chart2,
        fillPatternFn:(_,__)=>charts.FillPatternType.solid,
        fillColorFn:(BarChart barChart, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesBarChart.add(
      charts.Series(
        domainFn: (BarChart barChart, _) =>barChart.week,
        measureFn:(BarChart barChart, _)=> barChart.quantity,
        id: '2019',
        data: chart3,
        fillPatternFn:(_,__)=>charts.FillPatternType.solid,
        fillColorFn:(BarChart barChart, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    Timer.run(() => _showDialog());
    _seriesPieData =
        List<charts.Series<Task, String>>(); //These two belong in initState
    _seriesBarChart =
        List<charts.Series<BarChart, String>>(); //These two belong in initState
    _generateData();
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        _showDialogSavings();
        break;
      case 1:
        _showDialogRanking();
        break;
      case 2:
        _showDialogEarnings();
        break;
      default:
        _showDialog();
    }
  }


  int _currentIndex = 0;

  final _page = [
    SavingTotal(),
    RatingPage(),
    EarningsTotal(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('   Analytics'),
            bottom: TabBar(

              indicatorColor: Color(0xffffffff),
              tabs: [
                Tab(
                  icon: Icon(Icons.table_chart),
                  //text:"Analytics",
                ),
                Tab(icon: Icon(Icons.pie_chart)),
                Tab(icon: Icon(Icons.multiline_chart)),
              ],
            ),
            //title: Text('Charts'),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView( //This belongs under a scaffold
                  children: [
                    Padding(padding: EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'First test',
                                style: TextStyle(fontSize: 24.0),),
                              Expanded(
                                child: charts.BarChart(
                                  _seriesBarChart,
                                  animate: true,
                                  animationDuration: Duration(seconds: 3),
                                  barGroupingType: charts.BarGroupingType.grouped,
                                ),

                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Weekly Donations',
                                style: TextStyle(fontSize: 24.0),),
                              SizedBox(height: 10.0,),
                              Expanded(
                                child: charts.PieChart(
                                    _seriesPieData,
                                    animate: true,
                                    animationDuration: Duration(seconds: 3),
                                    behaviors: [
                                      new charts.DatumLegend(
                                        outsideJustification: charts
                                            .OutsideJustification.endDrawArea,
                                        horizontalFirst: false,
                                        desiredMaxRows: 2,
                                        cellPadding: new EdgeInsets.only(
                                            right: 4.0, bottom: 4.0),
                                        entryTextStyle: charts.TextStyleSpec(
                                            color: charts.MaterialPalette.purple
                                                .shadeDefault,
                                            fontFamily: 'Georgia',
                                            fontSize: 11
                                        ),
                                      ),
                                    ],
                                    defaultRenderer: new charts.ArcRendererConfig(
                                        arcWidth: 100,
                                        arcRendererDecorators: [
                                          new charts.ArcLabelDecorator(
                                              labelPosition: charts.ArcLabelPosition
                                                  .inside
                                          )
                                        ]
                                    )
                                ),

                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Weekly Donations',
                                style: TextStyle(fontSize: 24.0),),
                              SizedBox(height: 10.0,),
                              Expanded(
                                child: charts.PieChart(
                                    _seriesPieData,
                                    animate: true,
                                    animationDuration: Duration(seconds: 3),
                                    behaviors: [
                                      new charts.DatumLegend(
                                        outsideJustification: charts
                                            .OutsideJustification.endDrawArea,
                                        horizontalFirst: false,
                                        desiredMaxRows: 2,
                                        cellPadding: new EdgeInsets.only(
                                            right: 4.0, bottom: 4.0),
                                        entryTextStyle: charts.TextStyleSpec(
                                            color: charts.MaterialPalette.purple
                                                .shadeDefault,
                                            fontFamily: 'Georgia',
                                            fontSize: 11
                                        ),
                                      ),
                                    ],
                                    defaultRenderer: new charts.ArcRendererConfig(
                                        arcWidth: 100,
                                        arcRendererDecorators: [
                                          new charts.ArcLabelDecorator(
                                              labelPosition: charts.ArcLabelPosition
                                                  .inside
                                          )
                                        ]
                                    )
                                ),

                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey,
            selectedItemColor: Colors.black,
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
                _onItemTapped(index); //Set the pop up message
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.monetization_on),
                  title: Text('Saving')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                title: Text('Ranking'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.attach_money),
                  title: Text('Earnings')
              )
            ],
          ),
        ),
      ),
    );
  }


//  Creating the section for the pop up
  void _showDialog() {
// flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          elevation: 0.0,
          shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text("My Analytics coming soon!"),

          content: new Text(
              "Here is where all analytics will be displayed, please click the bottom buttons for further details!"),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Sounds good!"),
              textColor: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogSavings() {
// flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          elevation: 0.0,
          shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text("Savings coming soon!"),

          content: new Text(
              "Soon you will be able to see your weekly, monthly, and yearly savings as a result of "
                  "donating rather than disposal! "),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Sounds good!"),
              textColor: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogRanking() {
// flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          elevation: 0.0,
          shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text("Ranking coming soon"),

          content: new Text(
              "See where you stand out among other restaurant donators! Word is this will "
                  "become a focal point of our rewards program!"),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Sounds good"),
              textColor: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogEarnings() {
// flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          elevation: 0.0,
          shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: new Text("Earnings coming soon"),

          content: new Text(
              "Future versions of this app will allow meal purchases by your clients! This is where you will see"
                  " any earnings gained by this feature! "),
          actions: <Widget>[
// usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Sounds good!"),
              textColor: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Task{

  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue,this.colorval);
}//Pie chart

class BarChart{
  String week;
  int left;
  int quantity;
  BarChart(this.week, this.left, this.quantity);
}//Line chart