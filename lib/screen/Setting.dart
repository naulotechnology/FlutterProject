import 'package:flutter/material.dart';
import 'package:flutterproject/models/readwritefile.dart';

class Setting extends StatefulWidget {
  PlanningFormModel pfm;

  Setting(PlanningFormModel pfm) {
    this.pfm = pfm;
  }

  @override
  State<StatefulWidget> createState() {
    return MySetting(pfm);
  }
}

class MySetting extends State {
  PlanningFormModel pfm;

  List<String> optionListForInternet = <String>['Online', 'Offline'];
  String optionSelectConnectivity = "Online";

  MySetting(PlanningFormModel pfm) {
    this.pfm = pfm;
  }

  bool _value1 = false;
  void _onChanged1(bool value) {
    setState(() {
      pfm.isOnline = value;
      _value1 = value;

      print("Value is = $_value1");
      print("isOnline is = ${pfm.isOnline}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: ListView.builder(
          // scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
        return _makeElement(index);
      }),
    );
  }

  Widget _makeElement(int index) {
    if (index >= 6) {
      return null;
    } else if (index == 0) {
      return Center(
        child: Container(
          //  decoration: myDecoration(),
          height: 60,
          child: Padding(
            padding: EdgeInsets.only(top: 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (BuildContext content, int index) {
                return offLineOnLineToogle();
              },
            ),
          ),
        ),
      );
    }
  }

  offLineOnLineToogle() {
    double widths = MediaQuery.of(context).size.width;
    // double yourWidth = width * 0.65;

    return new Container(
      height: 50,
      width: widths,

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      // padding: new EdgeInsets.all(32.0),
      child: new Center(
        child: new Column(
          children: <Widget>[
            new SwitchListTile(
              value: _value1,
              onChanged: _onChanged1,
              title: new Text('Work in offline',
                  style: new TextStyle(
                      fontSize: 16,
                      fontFamily: "Chilanka",
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
