import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/models/readwritefile.dart';


class SavedStateFromFile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SaveStateFile();
  }
}

class SaveStateFile extends State {
  PlanningFormModel pfm = new PlanningFormModel();
  String saveState;

  TextEditingController saveStateFileController = TextEditingController();
    TextEditingController saveStateFileController1 = TextEditingController();


  void initState() {
    super.initState();
    saveStateFileController.text = pfm.savedStateFromFile;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: Form(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.title,
                controller: saveStateFileController,
                onSaved: (txt) {
                  setState(() {
                    saveStateFileController.text = pfm.savedStateFromFile;
                  });
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.title,
                controller: saveStateFileController1,
              ),
              RaisedButton(
                child: Text("MyButton"),
                onPressed: () {
                  setState(() {
                    handleText();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // String name() {
  //   setState(() {
  //     saveStateFileController.text = pfm.savedStateFromFile;
  //   });
  //   return saveStateFileController.toString();
  // }

  // void dispose() {
  //   // other dispose methods
  //   saveStateFileController.dispose();
  //   super.dispose();
  // }

  void handleText() {
    saveStateFileController.text = saveStateFileController1.text;
  }
}
