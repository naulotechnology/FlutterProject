import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/models/readwritefile.dart';
import 'package:flutterproject/screen/planninglayout.dart';

class SavedStateFromFile extends StatefulWidget {
  PlanningFormModel pfm;

  SavedStateFromFile(PlanningFormModel pfm) {
    this.pfm = pfm;
  }

  @override
  State<StatefulWidget> createState() {
    return SaveStateFile(pfm);
  }
}

class SaveStateFile extends State {
  PlanningFormModel pfm;
  MyFormState mfs;

  SaveStateFile(PlanningFormModel pfm) {
    this.pfm = pfm;
    this.mfs = new MyFormState(pfm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: new AppBar(
      //   automaticallyImplyLeading: true,
      //   title: new Text("Setting"),
      //   // leading: IconButton(icon:Icon(Icons.arrow_back),
      //   //   onPressed:() => Navigator.pop(context, false),
      //   // )
      // ),
      body: Center(
        child: ListView.builder(
            // scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
          return _makeElement(index);
        }),
      ),
    );
  }

  _makeElement(int index) {
    if (index >= 3) {
      return null;
     } 
    else if (index == 0) {
      return Center(
          child: Container(
        height: 3000,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 1,
            itemExtent: 3000,
            itemBuilder: (BuildContext content, int index) {
              return Container(
                child:Text(pfm.savedStateFromFile) ,
              );
            },
          ),
        ),
      ));
    }
  }
}
