import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MyChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ActualPlanVarianceChart();
  }
}

class ChartPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ChartPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class ActualPlanVarianceChart extends State {

  @override
  Widget build(BuildContext context) {
    var data = [
      new ChartPerYear('jan', 1200, Colors.red),
      new ChartPerYear('fab', 4200, Colors.yellow),
      new ChartPerYear('mar', 3000, Colors.green),
      new ChartPerYear('apr', 6000, Colors.black),
      new ChartPerYear('may', 2500, Colors.pink),
      new ChartPerYear('jun', 3500, Colors.pink),
      new ChartPerYear('jul', 1200, Colors.red),
      new ChartPerYear('aug', 14200, Colors.yellow),
      new ChartPerYear('sep', 3000, Colors.green),
      new ChartPerYear('oct', 6000, Colors.black),
      new ChartPerYear('nov', 2500, Colors.pink),
      new ChartPerYear('dec', 3500, Colors.pink),
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
      padding: new EdgeInsets.only(left: 25),
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
            chartWidget,
          ],
        ),
      ),
    );
  }
}
