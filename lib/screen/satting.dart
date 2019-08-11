import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/models/readwritefile.dart';


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

  SaveStateFile(PlanningFormModel pfm) {
    this.pfm = pfm;
  }

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
  void handleText() {
    saveStateFileController.text = saveStateFileController1.text;
  }
}
