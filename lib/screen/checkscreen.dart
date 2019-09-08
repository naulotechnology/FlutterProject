import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyCheckScreen();
  }
}

class MyCheckScreen extends State<CheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(
          "MyCheckScreen is Open",
          style: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
