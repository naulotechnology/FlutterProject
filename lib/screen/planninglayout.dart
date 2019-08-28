import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterproject/models/readwritefile.dart';
import 'package:material_switch/material_switch.dart';
import 'dart:async';

class MyForm extends StatefulWidget {
  PlanningFormModel pfm;
  MyForm(PlanningFormModel pfm) {
    this.pfm = pfm;
  }

  @override
  MyFormState createState() {
    return MyFormState(pfm);
  }
}

class MyFormState extends State<MyForm>
    with AutomaticKeepAliveClientMixin<MyForm> {
  String dropdownValue = "Plan";
  String dropdownValue1 = "Chemestry";
  String dropdowndate = "2018";
  String dropdownMonth = "Jan";
  int bordview = 1;
  String myheader = "Plan Page";

  int itemExtend;
  List<String> optionList = <String>['Month', 'Hour'];
  List<String> optionList1 = <String>['Plan', 'Actual'];

  String optionSelect = 'Month';
  String optionSelect1 = 'Plan';
  TextEditingController costElementController = TextEditingController();

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  PlanningFormModel pfm;

  TabController controller;

  Storage st;
  MonthlyPlan mp;
  bool showHour = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  MyFormState(PlanningFormModel pfm) {
    this.pfm = pfm;
    st = this.pfm.st;

    // with SingleTickerProviderStateMixin
    // controller = new TabController(vsync: this, length: 3);
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

  myDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(width: 1.0, color: Colors.lightBlue.shade500),
        bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    boardView(int i) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (BuildContext content, int index) {
          if (index == 0) {
            return costElementTable();
          } else if (index == 1) {
            if (i == 1) {
              return dataBody();
            } else if (i == 2) {
              return dataBodyActual();
            } else {
              return dataBodyVariance();
            }
          }
        },
      );
    }

    Widget _makeElement(int index) {
      if (index >= 6) {
        return null;
      } else if (index == 0) {
        return Center(
          child: Container(
            decoration: myDecoration(),
            height: 50,
            child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (BuildContext content, int index) {
                  return myHeader();
                },
              ),
            ),
          ),
        );
      } else if (index == 1) {
        return Container(
          height: 80,
          width: 80,
          padding: EdgeInsets.only(left: 49),
          //decoration: myDecoration(),
          child: Padding(
            padding: EdgeInsets.only(top: 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (BuildContext content, int index) {
                return myDropDownButtons();
              },
            ),
          ),
        );
      } else if (index == 2) {
        return Container(
          height: 70,
          width: 200,
          padding: EdgeInsets.only(left: 50),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: actualVariancePlanButton(),
          ),
        );
      } else if (index == 3) {
        return Container(
          height: 60,
          //  decoration: myDecoration(),
          child: Padding(
            padding:
                EdgeInsets.only(top: 10, bottom: 10, left: 115, right: 115),
            child: hourMonthToogleButton(),
          ),
        );
      } else if (index == 4) {
        return Container(
            height: 300,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 1,
                itemExtent: 56.8*(pfm.costElements.length),
                itemBuilder: (BuildContext content, int index) {
                  return boardView(bordview);
                },
              ),
            ));
      } else if (index == 5) {
        return Container(
          height: 50,
          width: 90,
          // padding: EdgeInsets.all(0),
          child: Padding(
            padding: EdgeInsets.only(top: 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (BuildContext content, int index) {
                return saveRetriveButton();
              },
            ),
          ),
        );
      }
    }

    return Scaffold(
      body: Center(
        child: ListView.builder(
            // scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
          return _makeElement(index);
        }),
      ),
    );
  }

  dataBody() {
    TextStyle tStyle = new TextStyle(
        fontSize: 15, color: Colors.black54, fontFamily: 'SourceSansPro');
    return Container(
      color: Color.fromARGB(100, 209, 209, 209),
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(
              "Jan",
              style: tStyle,
            ),
          ),
          DataColumn(
            label: Text("feb", style: tStyle),
          ),
          DataColumn(
            label: Text("mar", style: tStyle),
          ),
          DataColumn(
            label: Text("Apr", style: tStyle),
          ),
          DataColumn(
            label: Text("may", style: tStyle),
          ),
          DataColumn(
            label: Text("jun", style: tStyle),
          ),
          DataColumn(
            label: Text("july", style: tStyle),
          ),
          DataColumn(
            label: Text("Aug", style: tStyle),
          ),
          DataColumn(
            label: Text("Sep", style: tStyle),
          ),
          DataColumn(
            label: Text("Oct", style: tStyle),
          ),
          DataColumn(
            label: Text("Nov", style: tStyle),
          ),
          DataColumn(
            label: Text("Dec", style: tStyle),
          ),
        ],
        rows: pfm.costElements
            .map((attr) => DataRow(
                  cells: pfm.ceToMpMap[attr]
                      .getMonthlyPlan(showHour)
                      .map(
                        (monthlyAmount) => DataCell(
                              TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                    hintText: monthlyAmount.value.toString()),
                                onChanged: (txt) {
                                  pfm.setAmount(
                                      showHour, attr, txt, monthlyAmount.index);
                                },
                                onTap: () {
                                  print("${monthlyAmount.index}");
                                },
                              ),
                            ),
                      )
                      .toList(),
                ))
            .toList(),
      ),
    );
  }

  dataBodyActual() {
    TextStyle tStyle = new TextStyle(
        fontSize: 15, color: Colors.black54, fontFamily: 'SourceSansPro');
    return Container(
      color: Color.fromARGB(100, 209, 209, 209),
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(
              "Jan",
              style: tStyle,
            ),
          ),
          DataColumn(
            label: Text("feb", style: tStyle),
          ),
          DataColumn(
            label: Text("mar", style: tStyle),
          ),
          DataColumn(
            label: Text("Apr", style: tStyle),
          ),
          DataColumn(
            label: Text("may", style: tStyle),
          ),
          DataColumn(
            label: Text("jun", style: tStyle),
          ),
          DataColumn(
            label: Text("july", style: tStyle),
          ),
          DataColumn(
            label: Text("Aug", style: tStyle),
          ),
          DataColumn(
            label: Text("Sep", style: tStyle),
          ),
          DataColumn(
            label: Text("Oct", style: tStyle),
          ),
          DataColumn(
            label: Text("Nov", style: tStyle),
          ),
          DataColumn(
            label: Text("Dec", style: tStyle),
          ),
        ],
        rows: pfm.costElements
            .map((attr) => DataRow(
                  cells: pfm.ceToMaMap[attr]
                      .getMonthlyActual(showHour)
                      .map(
                        (monthlyAmount) => DataCell(

                            // TextField(
                            //   decoration: InputDecoration(
                            //       border: InputBorder.none,
                            //       labelStyle: TextStyle(
                            //           fontSize: 14, color: Colors.red),
                            //       hintText: monthlyAmount.value.toString()),
                            //   controller: costElementController,
                            // //  save the txt to amount in month
                            //   onChanged: (txt) {
                            //     pfm.setAmount(
                            //         showHour, attr, txt, monthlyAmount.index);
                            //   },
                            //   onTap: () {
                            //     print("${monthlyAmount.index}");
                            //   },
                            // ),
                            Text(monthlyAmount.value.toString())),
                      )
                      .toList(),
                ))
            .toList(),
      ),
    );
  }

  dataBodyVariance() {
    TextStyle tStyle = new TextStyle(
        fontSize: 15, color: Colors.black54, fontFamily: 'SourceSansPro');
    return Container(
      color: Color.fromARGB(100, 209, 209, 209),
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(
              "Jan",
              style: tStyle,
            ),
          ),
          DataColumn(
            label: Text("feb", style: tStyle),
          ),
          DataColumn(
            label: Text("mar", style: tStyle),
          ),
          DataColumn(
            label: Text("Apr", style: tStyle),
          ),
          DataColumn(
            label: Text("may", style: tStyle),
          ),
          DataColumn(
            label: Text("jun", style: tStyle),
          ),
          DataColumn(
            label: Text("july", style: tStyle),
          ),
          DataColumn(
            label: Text("Aug", style: tStyle),
          ),
          DataColumn(
            label: Text("Sep", style: tStyle),
          ),
          DataColumn(
            label: Text("Oct", style: tStyle),
          ),
          DataColumn(
            label: Text("Nov", style: tStyle),
          ),
          DataColumn(
            label: Text("Dec", style: tStyle),
          ),
        ],
        rows: pfm.costElements
            .map((attr) => DataRow(
                  cells: pfm.ceToMvMap[attr]
                      .getMonthlyVariance(showHour)
                      .map(
                        (monthlyAmount) => DataCell(
                            // TextField(
                            //   decoration: InputDecoration(
                            //       border: InputBorder.none,
                            //       labelStyle: TextStyle(
                            //           fontSize: 14, color: Colors.red),
                            //       hintText: monthlyAmount.value.toString()),
                            //   controller: costElementController,
                            //   //save the txt to amount in month
                            //   onChanged: (txt) {
                            //     pfm.setAmount(
                            //         showHour, attr, txt, monthlyAmount.index);
                            //   },
                            //   onTap: () {
                            //     print("${monthlyAmount.index}");
                            //   },
                            // ),
                            Text(monthlyAmount.value.toString())),
                      )
                      .toList(),
                ))
            .toList(),
      ),
    );
  }

  costElementTable() {
    return Container(
      width: 162,
      decoration: BoxDecoration(
        color: Color.fromARGB(100, 179, 179, 179),
        border: Border(
          // top: BorderSide(width: 1.0, color: Colors.lightBlue.shade500),
          // bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
          left: BorderSide(
            width: 1.0,
            color: Color.fromARGB(100, 120, 120, 120),
          ),
          right: BorderSide(
            width: 1.0,
            color: Color.fromARGB(100, 120, 120, 120),
          ),
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
          rows: pfm.costElements
              .map(
                (attr) => DataRow(
                      cells: [
                        /*1*/ DataCell(
                            Text(
                              attr,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
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

  saveRetriveButton() {
    return Container(
      child: Row(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {
                pfm.saveData();
              });
              // print("data wrote to file = ${pfm.toStringMa()}");
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
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
              String da = await st.readData();
              pfm.savedStateFromFile = da;

              //print(da);
              print("data read from file = $da");
            },
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
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

  hourMonthToogleButton() {
    return Container(
      height: 100,
      child: MaterialSwitch(
        padding: EdgeInsets.only(bottom: 12.0, left: 12.0),
        options: optionList,
        selectedOption: optionSelect,
        selectedBackgroundColor: Colors.blue,
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
    );
  }

  actualVariancePlanButton() {
    return Container(
      child: Row(
        children: <Widget>[
          MaterialButton(
            child: Text("Plan"),
            color: Colors.blue,
            textColor: Colors.white,
            textTheme: ButtonTextTheme.accent,
            elevation: 2,
            height: 40,
            //minWidth: 40,
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
            colorBrightness: Brightness.light,
            animationDuration: Duration(microseconds: 1000),
            onPressed: () {
              setState(() {
                bordview = 1;
                myheader = "Plan Page";
                print("this is Number ${pfm.costElements.length}");
              });
            },
          ),
          SizedBox(
            width: 5,
          ),
          MaterialButton(
            child: Text("Actual"),
            color: Colors.blue,
            textColor: Colors.white,
            textTheme: ButtonTextTheme.accent,
            elevation: 2,
            height: 40,
            minWidth: 40,
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
            colorBrightness: Brightness.light,
            animationDuration: Duration(microseconds: 1000),
            onPressed: () {
              setState(() {
                bordview = 2;
                myheader = "Actual Page";
              });
            },
          ),
          SizedBox(
            width: 5,
          ),
          MaterialButton(
            child: Text("Variance"),
            color: Colors.blue,
            textColor: Colors.white,
            textTheme: ButtonTextTheme.accent,
            elevation: 2,
            height: 40,
            minWidth: 40,
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            colorBrightness: Brightness.light,
            animationDuration: Duration(microseconds: 1000),
            onPressed: () {
              setState(() {
                bordview = 3;
                myheader = "Variance Page";
              });
            },
          ),
        ],
      ),
    );
  }

  myHeader() {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Center(
        child: Text(
          myheader,
          style: TextStyle(fontSize: 24, fontFamily: "SourceSansPro"),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  myDropDownButtons() {
    return Container(
      margin: EdgeInsets.only(top: 4),
      width: 350,
      height: 50,
      //  padding: EdgeInsets.only(top: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "DepartMent",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: 110,
                    //padding: EdgeInsets.symmetric(horizontal: 10.0),
                    //  padding: EdgeInsets.only(bottom: 10),
                    decoration: new BoxDecoration(
                        color: Color.fromARGB(100, 212, 212, 212),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: Color.fromARGB(100, 140, 140, 140),
                          width: 1,
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.blue.shade200,
                          ),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownValue1,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue1 = newValue;
                                  });
                                },
                                items: <String>[
                                  "Chemestry",
                                  "Nepali",
                                  "Physics"
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(fontSize: 12)),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Date",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: 80,
                    // padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: new BoxDecoration(
                        color: Color.fromARGB(100, 212, 212, 212),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: Color.fromARGB(100, 140, 140, 140),
                          width: 1.0,
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.blue.shade200,
                          ),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: dropdowndate,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdowndate = newValue;
                                  });
                                },
                                items: <String>["2018", "2019", "2022", "2023"]
                                    .map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(fontSize: 12)),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Month",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: 70,
                    // padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: new BoxDecoration(
                        color: Color.fromARGB(100, 212, 212, 212),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: Color.fromARGB(100, 140, 140, 140),
                          width: 1.0,
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.blue.shade200,
                          ),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: dropdownMonth,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownMonth = newValue;
                                  });
                                },
                                items: <String>[
                                  "Jan",
                                  "Feb",
                                  "Mar",
                                  "Apr",
                                  "jun",
                                  "jul",
                                  "Aug",
                                  "Sep",
                                  "Oct",
                                  "Nov",
                                  "Dec"
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(fontSize: 12)),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
