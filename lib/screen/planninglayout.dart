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
  String dropdownValue = "NauloTechnology";
  String dropdownValue1 = "Chemestry";

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

  @override
  Widget build(BuildContext context) {
    Widget tagList = Container(
      color: Colors.lightBlueAccent,
      padding: EdgeInsets.only(top: 30),
      // height: 239.0,
      child: Column(
        children: <Widget>[
          myDropDownButtons(),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 100),
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                height: 36,
                width: 122,
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
          )
        ],
      ),
    );

    boardView(int i) {
      return Container(
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
            itemExtent: 60 * pfm.costElements.length.toDouble(),
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
                      if (i == 1) {
                        return dataBody();
                      } else if (i == 2) {
                        return dataBodyActual();
                      } else {
                        return dataBodyVariance();
                      }
                    }
                  });
            },
          ));
    }

    double selectItemExtent() {
      return 280;
    }

    planPage() {
      return Container(
        //color: Colors.white10,
        decoration: BoxDecoration(
          color: Colors.white,
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
              return boardView(1);
            } else if (index == 2) {
              return saveRetriveButton();
            }
          },
        ),
      );
    }

    actualPage() {
      return Container(
        //color: Colors.white10,
        decoration: BoxDecoration(
          color: Colors.white,
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
              return boardView(2);
            } else if (index == 2) {
              return saveRetriveButton();
            }
          },
        ),
      );
    }

    variancePage() {
      return Container(
        //color: Colors.white10,
        decoration: BoxDecoration(
          color: Colors.white,
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
              return boardView(3);
            } else if (index == 2) {
              return saveRetriveButton();
            }
          },
        ),
      );
    }

    // return Scaffold(
    //   body: Container(
    //     height: 40,
    //     width: 180,
    //     child: MaterialSwitch(
    //       padding: EdgeInsets.only(bottom: 10.0, left: 15.0),
    //       options: optionList1,
    //       selectedOption: optionSelect1,
    //       selectedBackgroundColor: Colors.indigo,
    //       selectedTextColor: Colors.white,
    //       onSelect: (String optionList) {
    //         setState(() {
    //           optionSelect1 = optionList;
    //           if (optionSelect1 == "Plan") {
    //             Container(
    //               child: planPage(),
    //             );
    //           } else if (optionSelect1 == "Actual") {
    //             Container(
    //               child: actualPage(),
    //             );
    //           } else {
    //             Container(
    //               child: variancePage(),
    //             );
    //           }
    //         });
    //       },
    //     ),
    //   ),
    // );

    // int _currentIndex = 0;

    // void onTabTapped(int index) {
    //   setState(() {
    //     _currentIndex = index;
    //     if(index==1){
    //       Container(
    //          child: planPage(),
    //       );
    //     }
    //      if(index==2){
    //       Container(
    //          child: actualPage(),
    //       );
    //     }
    //      if(index==1){
    //       Container(
    //          child: variancePage(),
    //       );
    //     }
    //   });
    // }
    List<Widget> container = [
      new Container(
        child: planPage(),
      ),
    ];

    // return Scaffold(
    //   body: IndexedStack(
    //     index: _currentIndex,
    //     children: container,
    //   ),
    //   bottomNavigationBar: new BottomNavigationBar(
    //     fixedColor: Colors.black,
    //    // type: BottomNavigationBarType.fixed,
    //     onTap: onTabTapped,
    //     currentIndex: _currentIndex,
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: new Icon(Icons.format_list_bulleted),
    //          title: Text("data2")
    //       ),
    //       BottomNavigationBarItem(
    //         icon: new Icon(Icons.settings),
    //          title: Text("data1")
    //       ),
    //        BottomNavigationBarItem(
    //         icon: new Icon(Icons.hot_tub),
    //         title: Text("data")
    //       )
    //     ],
    //   ),
    //   backgroundColor: Colors.black,
    // );
    //String showValue = "plan";

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            body: TabBarView(
              children: [
                new Container(
                  child: planPage(),
                  //color: Colors.white,
                ),
                new Container(
                  child: actualPage(),
                  // color: Colors.lightGreen,
                ),
                new Container(
                  child: variancePage(),
                  // color: Colors.red,
                ),
              ],
            ),
            bottomNavigationBar: new TabBar(
              tabs: [
                Tab(
                  //icon: new Icon(Icons.home),
                  text: "plan",
                ),
                Tab(
                  //icon: new Icon(Icons.account_balance),
                  text: "actual",
                ),
                Tab(
                  //icon: new Icon(Icons.vibration),
                  text: "variance",
                ),
              ],
              labelColor: Colors.yellow,
              unselectedLabelColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.red,
            ),
            backgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }

  dataBody() {
    TextStyle tStyle = new TextStyle(
        fontSize: 15, color: Colors.black54, fontFamily: 'SourceSansPro');
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
                                controller: costElementController,
                                // save the txt to amount in month
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
                              TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                    hintText: monthlyAmount.value.toString()),
                                controller: costElementController,
                                // save the txt to amount in month
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

  dataBodyVariance() {
    TextStyle tStyle = new TextStyle(
        fontSize: 15, color: Colors.black54, fontFamily: 'SourceSansPro');
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
                              TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                    hintText: monthlyAmount.value.toString()),
                                controller: costElementController,
                                // save the txt to amount in month
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

  // returnCETextControllerValue() {
  //   int ceController = int.parse(costElementController.text);
  //   if (ceController == null) {
  //     return 1;
  //   } else {
  //     return ceController;
  //   }
  // }

  costElementTable() {
    return Container(
      width: 162,
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

  dateTable() {}

  saveRetriveButton() {
    return Container(
      padding: EdgeInsets.only(bottom: 200),
      child: Row(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {
                pfm.savePfmToFile();
              });
              print("data wrote to file = ${pfm.toStringMa()}");
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
      width: 160,
      // height: 170,
      padding: EdgeInsets.only(right: 30),
      child: Column(
        children: <Widget>[
          Text(
            "Company",
            style: TextStyle(fontSize: 12),
          ),
          Container(
           // width: 125,
            // padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: new BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color.fromRGBO(0, 0, 300, 0),
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
                    alignedDropdown: false,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        "NauloTechnology",
                        "MyTechnology",
                        "YourTechnology"
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
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "DepartMent",
            style: TextStyle(fontSize: 12),
          ),
          Container(
            width: 90,
            // padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: new BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color.fromRGBO(0, 0, 300, 0),
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
                    alignedDropdown: false,
                    child: DropdownButton<String>(
                      isExpanded: true,
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
                            child: Text(value, style: TextStyle(fontSize: 12)),
                          );
                        },
                      ).toList(),
                    ),
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
