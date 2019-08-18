import 'package:flutter/material.dart';
import 'package:flutterproject/models/readwritefile.dart';
import 'package:flutterproject/screen/myadminform.dart';
import 'package:flutterproject/screen/planninglayout.dart';
import 'package:flutterproject/screen/satting.dart';





void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
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
        return new MyAdminForm(pfm);

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
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
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





// class MyPageView extends StatefulWidget {
//   MyPageView({Key key}) : super(key: key);

//   _MyPageViewState createState() => _MyPageViewState();
// }

// class _MyPageViewState extends State<MyPageView> {
//   PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: PageView(
//           controller: _pageController,
//           children: [
//             Container(
//               color: Colors.red,
//               child: Center(
//                 child: RaisedButton(
//                   color: Colors.white,
//                   onPressed: () {
//                     if (_pageController.hasClients) {
//                       _pageController.animateToPage(
//                         1,
//                         duration: const Duration(milliseconds: 400),
//                         curve: Curves.easeInOut,
//                       );
//                     }
//                   },
//                   child: Text('Next'),
//                 ),
//               ),
//             ),
//             Container(
//               color: Colors.blue,
//               child: Center(
//                 child: RaisedButton(
//                   color: Colors.white,
//                   onPressed: () {
//                     if (_pageController.hasClients) {
//                       _pageController.animateToPage(
//                         0,
//                         duration: const Duration(milliseconds: 400),
//                         curve: Curves.easeInOut,
//                       );
//                     }
//                   },
//                   child: Text('Previous'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
