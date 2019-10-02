import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterproject/models/readwritefile.dart';
import 'package:material_switch/material_switch.dart';
import 'dart:async';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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

class MyFormState extends State<MyForm> {
  List<String> valueDepartment = [];

  String dropdownValue = "Plan";
  String dropdownValue1;
  String dropdowndate = "2018";
  String dropdownMonth = "Jan";

  int bordview = 1;
  int user;
  List<String> users;
  String _selectedDepartment;

  String myheader = "Plan Page";

  String connection;

  Color planbuttonColors = Colors.blue;
  Color actualbuttonColors = Colors.white;
  Color variancebuttonColors = Colors.white;

  Color plantextColors = Colors.white;
  Color actualtextColors = Colors.black;
  Color variancetextColors = Colors.black;

  int itemExtend;
  List<String> optionList = <String>['Month', 'Hour'];
  List<String> optionListForChart = <String>['Table', 'Chart'];
  List<String> optionList1 = <String>['Plan', 'Actual'];

  String optionSelect = 'Month';
  String optionSelectChart = 'Table';
  String optionSelect1 = 'Plan';
  TextEditingController costElementController = TextEditingController();

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  PlanningFormModel pfm;

  //TabController controller;

  Storage st;
  MonthlyPlan mp;
  bool showHour = false;
  bool showChart = false;

  List<String> _departments = [];

  bool connected;

  checkInterNetConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      print("internet access");
      connected = true;
    } else {
      connected = false;
      print("no internet access");
    }
  }

  String dropdownInitialValue;
  dropdownValue1ForDepartMent() {
    List<String> department = pfm.departments;

    // return valueDepartment;

    if (department == null) {
      return dropdownInitialValue = "looding";
    } else {
      return dropdownInitialValue = pfm.departments[0];
    }
  }

  dropDownValueForDepartment() {
    List<String> department = pfm.departments;
    if (department == null) {
      //valueDepartment.add("");
      return valueDepartment;
    } else {
      for (String i in department) {
        valueDepartment.add(i);
      }
      return valueDepartment;
    }
  }

  //Future<List<Users>> dropDownValueForDepartment1() async {
  //  List<String> valueDepartment;
  //  Future<List<String>> department = await pfm.getDepartments();

  //  return department;
  //}

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
    //subscription.cancel();
  }

  initState() {
    super.initState();
    // print("Hellow this is Department = $valueForDepartMent()");

    setState(() {
      // users = dropDownValueForDepartment();
      _selectedDepartment = "";
    });
  }

  MyFormState(PlanningFormModel pfm) {
    this.pfm = pfm;
    st = this.pfm.st;
  }

  Future<List<String>> fetchDepartments() async {
    List<String> d = await this.pfm.getDepartments();
    setState(() {
      this._departments = d;
    });
    // for (String dep in _departments) {

    // }
    print("Department is $d");
    return d;
  }

  String checkConnection() {
    if (connected == true) {
      return "Wifi Connected";
    } else {
      return "No internet Connection";
    }
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
        //  top: BorderSide(width: 1.0, color: Colors.lightBlue.shade500),
        bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    showOnlineOflineSnackBar(bool connected) {
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text('Show Snackbar'),
      //   duration: Duration(seconds: 3),
      // ));
    }

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

    fatchDataLoodingScreen() {
      return Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 130.0),
            ),
            CircularProgressIndicator(),
            Text(
              "Loading",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    myBordView() {
      return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 1,
          itemExtent: 60.0 * 10,
          itemBuilder: (BuildContext content, int index) {
            if (pfm.isFatches == true) {
              return fatchDataLoodingScreen();
            } else {
              return boardView(bordview);
            }
          },
        ),
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
          // padding: EdgeInsets.only(left: 49),
          margin: EdgeInsets.only(left: 16),
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
          // padding: EdgeInsets.only(left: 50),
          margin: EdgeInsets.only(left: 16),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: actualVariancePlanButton(),
          ),
        );
      } else if (index == 3) {
        return Row(
          children: <Widget>[
            Container(
              height: 60,
              width: 145,
              //  decoration: myDecoration(),
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 12),
                child: hourMonthToogleButton(),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 60,
              width: 145,
              //  decoration: myDecoration(),
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 12),
                child: chartTableleToogleButton(),
              ),
            ),
          ],
        );
      } else if (index == 4) {
        if (showChart == false) {
          return Container(
            height: 300,
            child: myBordView(),
          );
        } else {
          if (showHour == true) {
            return Container(
              height: 300,
              child: myChart(1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000,
                  9000, 10000, 11000, 12000),
            );
          } else {
            return Container(
              height: 300,
              child: myChart(5100, 1200, 13300, 9400, 7500, 10600, 7700, 880,
                  9900, 1200, 1100, 1200),
            );
          }
        }
      } else if (index == 5) {
        return Container(
          height: 60,
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
      // appBar: new AppBar(
      //  // automaticallyImplyLeading: false,
      //   title: new Text("MyTable"),
      //   // leading: IconButton(icon:Icon(Icons.arrow_back),
      //   //   onPressed:() => Navigator.pop(context, false),
      //   // )
      // ),
      // body: onConnectivityChange(pfm.result),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return new Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                height: 24.0,
                left: 0.0,
                right: 0.0,
                child: //showOnlineOflineSnackBar(connected),
                    Container(
                  color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                  child: Center(
                    child: Text(
                      "${connected ? 'Online' : 'Offline'}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 24),
                child: ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                  return _makeElement(index);
                }),
              )
            ],
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      // Center(
      //   child: ListView.builder(
      //       // scrollDirection: Axis.horizontal,
      //       itemBuilder: (BuildContext context, int index) {
      //     return _makeElement(index);
      //   }),
      // ),
    );
  }

  //chart
  myChart(int jan, int feb, int mar, int apr, int may, int jun, int july,
      int aug, int sep, int oct, int nov, int dec) {
    var data = [
      new ChartPerYear('jan', jan, Colors.red),
      new ChartPerYear('fab', feb, Colors.yellow),
      new ChartPerYear('mar', mar, Colors.green),
      new ChartPerYear('apr', apr, Colors.black),
      new ChartPerYear('may', may, Colors.pink),
      new ChartPerYear('jun', jun, Colors.pink),
      new ChartPerYear('jul', july, Colors.red),
      new ChartPerYear('aug', aug, Colors.yellow),
      new ChartPerYear('sep', sep, Colors.green),
      new ChartPerYear('oct', oct, Colors.black),
      new ChartPerYear('nov', nov, Colors.pink),
      new ChartPerYear('dec', dec, Colors.pink),
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

    return chartWidget;
  }

  dataBody() {
    TextStyle tStyle = new TextStyle(
        fontSize: 15, color: Colors.black54, fontFamily: 'SourceSansPro');
    return Container(
      color: Color.fromARGB(80, 209, 209, 209),
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
                                labelStyle:
                                    TextStyle(fontSize: 14, color: Colors.red),
                                hintText: monthlyAmount.value.toString()),
                            onChanged: (txt) {
                              pfm.setAmount(
                                  showHour, attr, txt, monthlyAmount.index);
                            },
                            onTap: () {
                              print("index is ${monthlyAmount.index}");
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
      color: Color.fromARGB(100, 112, 112, 112),
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
                        (monthlyAmount) =>
                            DataCell(Text(monthlyAmount.value.toString())),
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
      color: Color.fromARGB(100, 112, 112, 112),
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
                        (monthlyAmount) =>
                            DataCell(Text(monthlyAmount.value.toString())),
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
                      print('Selected cost Elements = ${attr}');
                    }),
                  ],
                ),
              )
              .toList()),
    );
  }

  saveRetriveButton() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 80),
      child: Row(
        children: <Widget>[
          MaterialButton(
            onPressed: () {
              setState(() {
                pfm.saveData();
                //pfm.planningFormModelJSONtoMp();
                print("data");
              });
              // print("data wrote to file = ${pfm.planningFormModelMptoJSON()}");
              //  print( "data  i checked = ${pfm.}");
            },
            child: Text("Save"),
            height: 40,
            color: Colors.blue,
            textColor: Colors.white,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          MaterialButton(
            onPressed: () async {
              // String da = await st.readData();
              // pfm.savedStateFromFile = da;
              List<String> st = await pfm.getDepartments();

              //print("Value OF Department is = ${fetchDepartments()}");
              print("Value OF Department is = $st");
              // print("data read from file = $da");
            },
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Text("Retrive"),
            height: 40,
            color: Colors.blue,
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
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

  chartTableleToogleButton() {
    return Container(
      height: 100,
      child: MaterialSwitch(
        padding: EdgeInsets.only(bottom: 12.0, left: 12.0),
        options: optionListForChart,
        selectedOption: optionSelectChart,
        selectedBackgroundColor: Colors.blue,
        selectedTextColor: Colors.white,
        onSelect: (String optionList) {
          setState(() {
            optionSelectChart = optionList;
            if (optionSelectChart == "Table") {
              showChart = false;
              print("Table");
            } else {
              showChart = true;
              print("Chart");
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
            color: planbuttonColors,
            textColor: plantextColors,
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

                planbuttonColors = Colors.blue;
                actualbuttonColors = Colors.white;
                variancebuttonColors = Colors.white;
                plantextColors = Colors.white;
                actualtextColors = Colors.black;
                variancetextColors = Colors.black;
              });
            },
          ),
          SizedBox(
            width: 5,
          ),
          MaterialButton(
            child: Text("Actual"),
            color: actualbuttonColors,
            textColor: actualtextColors,
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

                actualbuttonColors = Colors.blue;
                planbuttonColors = Colors.white;
                variancebuttonColors = Colors.white;
                actualtextColors = Colors.white;
                plantextColors = Colors.black;
                variancetextColors = Colors.black;
              });
            },
          ),
          SizedBox(
            width: 5,
          ),
          MaterialButton(
            child: Text("Variance"),
            color: variancebuttonColors,
            textColor: variancetextColors,
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

                variancebuttonColors = Colors.blue;
                actualbuttonColors = Colors.white;
                planbuttonColors = Colors.white;
                variancetextColors = Colors.white;
                plantextColors = Colors.black;
                actualtextColors = Colors.black;
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
    //String value1 = "pra";

    // var users = <String>["pra","philip",'bidari'];

    /// String depValue = user == null ? null : users[user];
    return Container(
      margin: EdgeInsets.only(top: 4),
      width: 330,
      height: 50,
      //  padding: EdgeInsets.only(top: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Department",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: 150,
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
                              // new async dropDown
                              child: FutureBuilder<List<String>>(
                                  future: this.fetchDepartments(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<String>> snapshot) {
                                    if (snapshot.hasData) {
                                      return DropdownButton<String>(
                                        value: this.user == null
                                            ? null
                                            : _departments[user],
                                        hint: Text(
                                          'Selec a Department',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        isExpanded: true,
                                        items: snapshot.data
                                            .map((dept) =>
                                                DropdownMenuItem<String>(
                                                  child: Text(
                                                    dept.toString(),
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  value: dept,
                                                ))
                                            .toList(),
                                        onChanged: (String selectedDept) {
                                          print("selected deptment is = " +
                                              selectedDept);
                                          setState(() {
                                            user = _departments
                                                .indexOf(selectedDept);

                                            print(
                                                "indexOf selected deptment is = $user");
                                          });
                                        },
                                      );
                                    } else
                                      return CircularProgressIndicator();
                                  }),
                              //end new async dorpDown
                              /*
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Text("Select Department",
                                    style: TextStyle(fontSize: 12)),
                                value: this._selectedDepartment == null ? null : this._selectedDepartment,
                                onChanged: (String newValue) {
                                  setState(() {
                                    //user = users.indexOf(newValue);
                                    print("new item "+newValue+" selected");
                                    //value1 = newValue;
                                  });
                                },
                              
                                items: this.pfm.departments.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(fontSize: 12)),
                                    );
                                  },
                                ).toList(),
                              ),
                              */
                              //
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

class ChartPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ChartPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
