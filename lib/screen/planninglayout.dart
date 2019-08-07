import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterproject/models/readwritefile.dart';
import 'package:material_switch/material_switch.dart';
import 'dart:async';

class MyForm extends StatefulWidget {
  @override
  MyFormState createState() {
    return MyFormState();
  }
}

class MyFormState extends State<MyForm> {
  String dropdownValue = "Naulo Technology";
  String dropdownValue1 = "Nepali";

  int itemExtend;
  List<String> optionList = <String>['Month', 'Hour'];

  String optionSelect = 'Month';

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  PlanningFormModel pmf;

  Storage st;
  MonthlyPlan mp;
  bool showHour = false;

  @override
  void initState() {
    //attributes = Attribute.getAttributes();
    pmf = new PlanningFormModel();
    mp = new MonthlyPlan();
    st = new Storage();

    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        //_kDayPickerRowHeight: 22,
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2030));

    if (picked != null && picked != _date) {
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null && picked != _time) {
      print('Time selected: ${_time.toString()}');
      setState(() {
        _time = picked;
      });
    }
  }

  void onChange(bool showHours) {
    this.showHour = showHours;
  }

  @override
  Widget build(BuildContext context) {
    Widget tagList = Container(
      color: Colors.lightBlueAccent,
      padding: EdgeInsets.only(top: 30),
      // height: 239.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 350),
                ),
                // MyDateTime(),
                myDropDownButtons(),
                Row(
                  children: <Widget>[
                    //  new Text('Date selected: ${_date.toString()}'),
                    // new RaisedButton(
                    //   child: new Text("Select Date"),
                    //   onPressed: () {
                    //     _selectDate(context);
                    //   },
                    // ),
                    // new Text(' '),
                    // //  new Text('Time selected: ${_time.toString()}'),
                    // new RaisedButton(
                    //   child: new Text("Select Time"),
                    //   onPressed: () {
                    //     _selectTime(context);
                    //   },
                    // ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    //Switch Button Start
                    SizedBox(
                      height: 75,
                    ),
                    Container(
                      height: 40,
                      width: 180,
                      child: MaterialSwitch(
                        padding: EdgeInsets.only(bottom: 10.0, left: 15.0),
                        options: optionList,
                        selectedOption: optionSelect,
                        selectedBackgroundColor: Colors.indigo,
                        selectedTextColor: Colors.white,
                        onSelect: (String optionList) {
                          setState(() {
                            optionSelect = optionList;
                            if (optionSelect == "Month") {
                              showHour = false;
                              print("Month");
                            } else {
                              showHour = true;
                              print("Hour");
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),

                //Show date and time
                // Column(
                //   children: <Widget>[
                //     new Text('Date : ${_date.toString()}'),
                //     new Text('Time : ${_time.toString()}')
                //   ],
                // )
              ],
            ),
          )
        ],
      ),
    );

    Widget boardView = Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
            bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
          ),
        ),
        padding: EdgeInsets.only(top: 1),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 1,
          itemExtent: 60 * pmf.costElements.length.toDouble(),
          itemBuilder: (BuildContext context, int index) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 12,
                // itemExtent: 2000,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return costElementTable();
                  } else if (index == 1) {
                    return dataBody();
                  }
                });
          },
        ));

    double selectItemExtent() {
      return 280;
    }

    //  int _value=0;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.lightBlue.shade500),
            bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
          ),
        ),
        child: new ListView.builder(
          itemCount: 3,
          itemExtent: selectItemExtent(),
          shrinkWrap: true,
          //reverse: true,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return tagList;
            } else if (index == 1) {
              return boardView;
            } else if (index == 2) {
              return saveRetriveButton();
            }
          },
        ),
        // child: new ListView.builder(
        //   itemCount: 3,
        //    itemExtent: selectItemExtent(),
        //   itemBuilder: (BuildContext context, int index) {
        //     if (index == 0) {
        //       return ListView.builder(
        //         itemCount: 1,
        //         itemExtent: 250,
        //         itemBuilder: (BuildContext context, int index) {
        //           return tagList;
        //         },
        //       );
        //     } else if (index == 1) {
        //       return ListView.builder(
        //         itemCount: 1,
        //         itemExtent: 350,
        //         itemBuilder: (BuildContext context, int index) {
        //           return boardView;
        //         },
        //       );
        //     } else if (index == 2) {
        //       return ListView.builder(
        //         itemCount: 1,
        //         itemExtent: 50,
        //         itemBuilder: (BuildContext context, int index) {
        //           return saveRetriveButton();
        //         },
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }

  dataBody() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.lightBlue.shade500),
          bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
          left: BorderSide(width: 1.0, color: Colors.lightBlue.shade500),
          right: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
        ),
      ),
      child: DataTable(
        columns: [
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
            .map((attr) => DataRow(
                  cells: pmf.monthLevelPlan[attr]
                      .getMonthlyPlan(showHour)
                      .map(
                        (monthlyAmount) => DataCell(
                              TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                    hintText: monthlyAmount.value.toString()),
                                // save the txt to amount in month
                                onChanged: (txt) {
                                  pmf.setAmount(
                                      showHour, attr, txt, monthlyAmount.index);
                                },
                                onTap: () {
                                  print("${monthlyAmount.index}");
                                },
                              ),
                            ),
                        // DataCell(
                        //       Text(monthlyAmount.toString()),
                        //       onTap: () {
                        //         print('Selected $monthlyAmount');
                        //       },
                        //     ),
                      )
                      .toList(),
                ))
            .toList(),
      ),
    );
  }

  costElementTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.lightBlue.shade500),
          bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
          left: BorderSide(width: 1.0, color: Colors.lightBlue.shade500),
          right: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
        ),
      ),
      child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                "Date",
                style: TextStyle(fontSize: 18, fontFamily: 'SourceSansPro'),
              ),
            ),
          ],
          rows: pmf.costElements
              .map(
                (attr) => DataRow(
                      cells: [
                        /*1*/ DataCell(
                            Text(
                              attr,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.red[50],
                                  fontFamily: 'SourceSansPro'),
                            ), onTap: () {
                          print('Selected ${attr}');
                        }),
                      ],
                    ),
              )
              .toList()),
    );
  }

  dateTable() {}

  saveRetriveButton() {
    return Container(
      padding: EdgeInsets.only(bottom: 200),
      child: Row(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {
                pmf.savePfmToFile();
              });
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: const Text('Save', style: TextStyle(fontSize: 20)),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              String readData = await (st.readData());
              print(readData);
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: const Text('Read', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }

  // Widget genderDropdownContainer() {
  //   return new Container(
  //     decoration: new BoxDecoration(
  //         color: Colors.blueGrey,
  //         borderRadius: BorderRadius.circular(2),
  //         border: Border.all(
  //             color: Color.fromRGBO(112, 112, 112, 1.0), width: 1.0)),
  //     child: myDropDownButtons(), //DropDownButton
  //   );
  // }

  myDropDownButtons() {
    return Container(
      width: 170,
      height: 170,
      decoration: new BoxDecoration(
          border: Border.all(
        color: Color.fromRGBO(220, 0, 100, 1),
        width: 2.0,
      )),
      child: Column(
        children: <Widget>[
          Text(
            "Company",
            style: TextStyle(fontSize: 12),
          ),
          Container(
            decoration: new BoxDecoration(
                color: Colors.tealAccent,
                border: Border.all(
                  color: Color.fromRGBO(220, 0, 100, 1),
                  width: 1.0,
                )),
            child: Column(
              children: <Widget>[
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.blue.shade200,
                  ),
                  child: DropdownButton<String>(
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
                          child: Text(value, style: TextStyle(fontSize: 12)),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "DepartMent",
            style: TextStyle(fontSize: 12),
          ),
          Container(
            decoration: new BoxDecoration(
                color: Colors.tealAccent,
                border: Border.all(
                  color: Color.fromRGBO(220, 0, 100, 1),
                  width: 1.0,
                )),
            child: Column(
              children: <Widget>[
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.blue.shade200,
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue1,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue1 = newValue;
                      });
                    },
                    items: <String>["Nepali", "Chemestry", "Physics"]
                        .map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(fontSize: 12)),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//  Container(
//       decoration: new BoxDecoration(
//           color: Colors.blueGrey,
//           borderRadius: BorderRadius.circular(2),
//           border: Border.all(
//               color: Color.fromRGBO(112, 112, 112, 1.0), width: 1.0)),
//       child: Column(
//         children: <Widget>[
//           Text(
//             "Company",
//             style: TextStyle(fontSize: 12),
//           ),
//           DropdownButton<String>(
//             value: dropdownValue,
//             onChanged: (String newValue) {
//               setState(() {
//                 dropdownValue = newValue;
//               });
//             },
//             items: <String>[
//               "Naulo Technology",
//               "My Technology",
//               "Your Technology"
//             ].map<DropdownMenuItem<String>>(
//               (String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value, style: TextStyle(fontSize: 12)),
//                 );
//               },
//             ).toList(),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           Text(
//             "DepartMent",
//             style: TextStyle(fontSize: 12),
//           ),
//           DropdownButton<String>(
//             value: dropdownValue1,
//             onChanged: (String newValue) {
//               setState(() {
//                 dropdownValue1 = newValue;
//               });
//             },
//             items: <String>["Nepali", "Chemestry", "Physics"]
//                 .map<DropdownMenuItem<String>>(
//               (String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value, style: TextStyle(fontSize: 12)),
//                 );
//               },
//             ).toList(),
//           ),
//         ],
//       ),
//     );
