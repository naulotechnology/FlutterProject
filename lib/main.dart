import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterproject/models/readwritefile.dart';
import 'package:flutterproject/screen/planninglayout.dart';
import 'package:flutterproject/screen/satting.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("MyTable", Icons.table_chart),
    new DrawerItem("MyForm", Icons.folder),
    new DrawerItem("Setting", Icons.settings)
  ];

  @override
  State<StatefulWidget> createState() {
    return new _HomepageState();
  }
}

class _HomepageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedDrawerIndex = 0;
  PlanningFormModel pfm = new PlanningFormModel();

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new MyForm(pfm);
      case 1:
        return new SavedStateFromFile(pfm);

      default:
        return new SavedStateFromFile(pfm);
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        // automaticallyImplyLeading: false,
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
        // leading: IconButton(icon:Icon(Icons.arrow_back),
        //   onPressed:() => Navigator.pop(context, false),
        // )
      ),
      drawer: new Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('PrakashBidari'),
              accountEmail: Text('Pbidari46@gmail.com'),
              currentAccountPicture: ClipOval(
                child: Image.asset(
                  'assets/profile.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}


class MySplashScreen extends StatefulWidget {
  @override
  _MyAppState createState() =>  _MyAppState();
}

class _MyAppState extends State<MySplashScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    List<Color> color = List<Color>();
    color.add(Colors.red);
    color.add(Colors.blue);
    color.add(Colors.green);

    return  SplashScreen(
      seconds: 4,
      navigateAfterSeconds:  HomePage(),
      title:  Text('Welcome,SplashScreen',
      style: TextStyle(color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),),
     // image: Image.asset('image1.jpg'),
      backgroundColor: Color.fromARGB(200, 226, 66, 23),
      styleTextUnderTheLoader: TextStyle(),
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.white
    );
  }
}
