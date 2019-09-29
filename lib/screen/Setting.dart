import 'package:flutter/material.dart';
import 'package:material_switch/material_switch.dart';

class Setting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MySetting();
  }
}

class MySetting extends State {
  List<String> optionListForInternet = <String>['Online', 'Offline'];
  String optionSelectConnectivity = "Online";

  bool _value1 = false;
  void _onChanged1(bool value) => setState(() => _value1 = value);

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

  //offLineOnLineToogle() {
  //   return Container(
  //     height: 40,
  //     width: 110,
  //     child: MaterialSwitch(
  //       padding: EdgeInsets.only(bottom: 12.0, left: 6.0),
  //       options: optionListForInternet,
  //       selectedOption: optionSelectConnectivity,
  //       selectedBackgroundColor: Colors.blue,
  //       selectedTextColor: Colors.white,
  //       onSelect: (String optionList) {
  //         setState(() {
  //           optionSelectConnectivity = optionList;
  //           if (optionSelectConnectivity == "Online") {
  //             print("Online");
  //           } else {
  //             print("Offline");
  //           }
  //         });
  //       },
  //     ),
  //   );
  // }
}
