import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/models/readwritefile.dart';


class MyAdminForm extends StatefulWidget {
  PlanningFormModel pfm;

  MyAdminForm(PlanningFormModel pfm) {
    this.pfm = pfm;
  }
  @override
  State<StatefulWidget> createState() {
    return AdminForm(pfm);
  }
}

class AdminForm extends State {
  PlanningFormModel pfm;

  AdminForm(PlanningFormModel pfm) {
    this.pfm = pfm;
  }

  Storage st;
  @override
  void initState() {
    st = new Storage();
    super.initState();
  }

  var displayResult = "";
  TextEditingController companyController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  // File jsonFile;
  // Directory dir;
  // String fileName = "myJSONFile.json";
  // bool fileExists = false;
  // Map<String, String> fileContent;

  // @override
  // void initState() {
  //   st = new Storage();
  //   super.initState();
  //   getApplicationDocumentsDirectory().then((Directory directory) {
  //     dir = directory;
  //     jsonFile = new File(dir.path + "/" + fileName);
  //     fileExists = jsonFile.existsSync();
  //     if (fileExists)
  //       this.setState(
  //           () => fileContent = json.decode(jsonFile.readAsStringSync())); //
  //   });
  // }

  // void createFile(Map<String, String> content, Directory dir, String fileName) {
  //   print("Creating file!");
  //   File file = new File(dir.path + "/" + fileName);
  //   file.createSync();
  //   fileExists = true;
  //   file.writeAsStringSync(json.encode(content)); //
  // }

  // void writeToFile(String key, String value) {
  //   print("Writing to file!");
  //   Map<String, String> content = {key: value};
  //   if (fileExists) {
  //     print("File exists");
  //     Map<String, String> jsonFileContent =
  //         json.decode(jsonFile.readAsStringSync());
  //     jsonFileContent.addAll(content);
  //     jsonFile.writeAsStringSync(json.encode(jsonFileContent)); //
  //   } else {
  //     print("File does not exist!");
  //     createFile(content, dir, fileName);
  //   }
  //   this.setState(
  //       () => fileContent = json.decode(jsonFile.readAsStringSync())); //
  //   print(fileContent);
  // }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      // appBar: new AppBar(
      //   automaticallyImplyLeading: true,
      //   title: new Text("AdminForm"),
      //   // leading: IconButton(icon:Icon(Icons.arrow_back),
      //   //   onPressed:() => Navigator.pop(context, false),
      //   // )
      // ),
      //backgroundColor: Colors.red,
      body: SafeArea(
        child: Form(
          child: ListView(children: <Widget>[
            new Text(st.toString()),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
            ),
            Container(child: Text("Company: ", style: textStyle)),
            Container(
              decoration: new BoxDecoration(
                
              ),
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
                        pfm.savePfmToFile();
                      });
                      // pfm.savePfmToFile();
                      print("Hellow Prakash");
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
                      child:
                          const Text('Write', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
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
                    onPressed: () async {
                      String da = await st.readData();
                      print(da);
                      print("Hellow Prakash");
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
            ),
            Container(
              child: Text("${this.displayResult}", style: textStyle),
            )
          ]),
        ),
      ),
    );
  }
}
