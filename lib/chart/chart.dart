import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MyChart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ActualPlanVarianceChart();
  }

}

class ChartPerYear{
final String year;
  final int clicks;
  final charts.Color color;

  ChartPerYear(this.year,this.clicks,Color color)
    : this.color = new charts.Color(r: color.red,g: color.green,b: color.blue,a: color.alpha);

}

class ActualPlanVarianceChart extends State{
  int _counter = 0;

  void _incrementCounter(){
    setState(() {
     _counter++; 
    });
  }
    @override
  Widget build(BuildContext context) {
    var data = [
       new ChartPerYear('jan', 12, Colors.red),
      new ChartPerYear('fab', 42, Colors.yellow),
      new ChartPerYear('mar', 20, Colors.green),
      new ChartPerYear('apr', 60, Colors.black),
      new ChartPerYear('may', _counter+10, Colors.pink),
    ];

     var series = [
      new charts.Series(
        domainFn: (ChartPerYear clickData, _) => clickData.year,
        measureFn: (ChartPerYear clickData, _) => clickData.clicks,
        colorFn: (ChartPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
    );
    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            chartWidget,
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }

}