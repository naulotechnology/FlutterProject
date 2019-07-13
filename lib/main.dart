import 'package:flutter/material.dart';
import 'package:flutterform/screen/planninglayout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}


