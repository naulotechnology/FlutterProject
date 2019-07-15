import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAdminForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminForm();
  }
}

class AdminForm extends State {
  @override
  void initState() {
    super.initState();
  }

  var displayResult;
  TextEditingController companyController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      //backgroundColor: Colors.red,
      body: SafeArea(
        child: Form(
          child: ListView(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 30),
            ),
            Container(child: Text("Company: ", style: textStyle)),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: textStyle,
                controller: companyController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter Company Name';
                  }
                },
                decoration: InputDecoration(
                    //labelText: 'Company',
                    hintText: 'Enter Company Name',
                    labelStyle: textStyle,
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            Container(child: Text("DepartMent: ", style: textStyle)),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: textStyle,
                controller: departmentController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter DepartMent Name';
                  }
                },
                decoration: InputDecoration(
                    //labelText: 'Company',
                    hintText: 'Enter Department Name',
                    labelStyle: textStyle,
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        print("Hellow Prakash");
                        this.displayResult = names();
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
                      padding: const EdgeInsets.all(10.0),
                      child:
                          const Text('Submit', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Text(this.displayResult, style: textStyle),
            )
          ]),
        ),
      ),
    );
  }

  String names() {
    String company = (companyController.text).toString();
    String department = (departmentController.text).toString();
    String result = "${company + department}";
    return result;
  }
}
