import 'package:flutter/material.dart';
import 'package:flutterproject/models/readwritefile.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stack overflow',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      routes: {},
      home: KanbanState(),
    );
  }
}

class KanbanState extends StatefulWidget {
  @override
  KanbanStateState createState() {
    return KanbanStateState();
  }
}

class KanbanStateState extends State<KanbanState> {
    String dropdownValue = "Naulo Technology";
    PlanningFormModel pmf;
    MonthlyPlan mp;

    @override
  void initState() {
    //attributes = Attribute.getAttributes();
    pmf = new PlanningFormModel();
    mp = new MonthlyPlan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget tagList = Container(
      color: Colors.green,
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            children: <Widget>[
              DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>[
                "Naulo Technology",
                "My Technology",
                "Your Technology"
              ].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            ],
          )
        ],
      ),
    );

    Widget boardView = Container(
      color: Colors.blue,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {},
            title: Row(
              children: <Widget>[
                dataBody()
              ],
            ),
          );
        },
      ),
    );

    //  int _value=0;
    return Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          title: Text("Test title"),
        ),
        body: Container(
          color: Colors.amber,
          child: new Column(
            children: <Widget>[
              tagList,
              Expanded(
                child: boardView,
              )
            ],
          ),
          margin: EdgeInsets.all(10.0),
        ));
  }

  dataBody() {
    return DataTable(
      columns: [
        DataColumn(
          label: Text("Date"),
        ),
        DataColumn(
          label: Text("Jan"),
        ),
        DataColumn(
          label: Text("feb"),
        ),
        DataColumn(
          label: Text("mar"),
        ),
        DataColumn(
          label: Text("Apr"),
        ),
        DataColumn(
          label: Text("may"),
        ),
        DataColumn(
          label: Text("jun"),
        ),
        DataColumn(
          label: Text("july"),
        ),
        DataColumn(
          label: Text("Aug"),
        ),
        DataColumn(
          label: Text("Sep"),
        ),
        DataColumn(
          label: Text("Oct"),
        ),
        DataColumn(
          label: Text("Nov"),
        ),
        DataColumn(
          label: Text("Dec"),
        ),
      ],
      rows: pmf.costElements
          .map((attr) => DataRow(cells: [
                /*1*/ DataCell(
                  Text(attr),
                  onTap: () {
                    print('Selected ${attr}');
                  },
                ),
                DataCell(
                  Text(""),
                  onTap: () {},
                ),

                /*1*/ DataCell(
                  Text(""),
                  onTap: () {
                    print('');
                  },
                ),
                /*1*/ DataCell(
                  Text(""),
                  onTap: () {
                    print('');
                  },
                ),
                /*1*/ DataCell(
                  Text(""),
                  onTap: () {
                    print('');
                  },
                ),
                /*1*/ DataCell(
                  Text(""),
                  onTap: () {
                    print('');
                  },
                ),
                /*1*/ DataCell(
                  Text(""),
                  onTap: () {
                    print('');
                  },
                ),
                DataCell(
                  Text(""),
                  onTap: () {},
                ),
                /*1*/ DataCell(
                  Text(""),
                  onTap: () {
                    print('');
                  },
                ),
                /*1*/ DataCell(
                  Text(""),
                  onTap: () {
                    print('');
                  },
                ),
                /*1*/ DataCell(
                  Text(""),
                  onTap: () {
                    print('');
                  },
                ),
                /*1*/ DataCell(
                  Text(""),
                  onTap: () {
                    print('');
                  },
                ),
                /*1*/ DataCell(
                  Text(""),
                  onTap: () {
                    print('');
                  },
                ),
              ]))
          .toList(),
    );

  }

}

