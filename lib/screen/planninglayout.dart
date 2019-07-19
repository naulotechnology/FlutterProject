import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/models/readwritefile.dart';

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyGoodForm();
  }
}

class MyGoodForm extends State {
  //List<Attribute> attributes;
 PlanningFormModel pmf;
MonthlyPlan mp;

  @override
  void initState() {
    //attributes = Attribute.getAttributes();
    pmf = new PlanningFormModel();    
//    mp = new MonthlyPlan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Flutter Form"),
      //   backgroundColor: Colors.blueGrey[900],
      // ),
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Center(
              child: dataBody(),
            )
          ],
        ),
      ),
    );
  }

  dataBody() {
    return DataTable(
      
      columns: pmf.periods
          .map((period)=>
            DataColumn( 
              label: Text(period),
            ))
          .toList(),
        
        rows: pmf.costElements
          .map((attr) => DataRow(
           // label:Text(attr),
            //cells: 
            //[
              //DataCell(Text(attr),onTap:(){print('Selected ${attr}');},),
              cells:pmf.monthLevelPlan[attr].amountInPeriod
              .map((cellVal) =>
                DataCell(Text(cellVal.toString()),onTap:(){print('Selected $cellVal');},),
              ).toList(), 
              //]
              ))
          .toList(),
    );
  }
}

// class Attribute {
//   String rowName;
//   String columnName;

//         Attribute({this.rowName});


//   static List<Attribute> getAttributes() {
//     return <Attribute>[
//       Attribute(rowName: "Employee"),
//       Attribute(rowName: "Transport"),
//       Attribute(rowName: "ItCost"),
//       Attribute(rowName: "Deep"),
//     ];
//   }
// }
