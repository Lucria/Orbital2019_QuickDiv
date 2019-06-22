import 'package:flutter/material.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'pages/add_user_group.dart';

import 'package:flutter/rendering.dart'; // to be delete - for debugging the widget lazyout.

void main() {
  // debugPaintSizeEnabled = true; // to view the rendering of the widget.
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true; // show where the tab event is registered. for tab listener.
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // Inherit class from material.dart package
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String,dynamic>> _groups = [];
  
   void _addGroups(Map<String, dynamic> groups) {
    print("[ProductsManager Widget]  _addProducts()");
    setState(() {
      _groups.add(groups);
    });
    print(_groups);
  }

  void _deleteProduct(int index) {
    setState(() {
      _groups.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("[main Widget] build()");

    return MaterialApp(
      // debugShowMaterialGrid: true, // to show the grid of the layout.
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.pink,
          accentColor: Colors.blue),
      debugShowCheckedModeBanner: false, //remove debug LOL
      routes: {
        '/': (BuildContext context) => SplashScreen(),
        '/home': (BuildContext context) => MyHomePage(_groups),
        '/create': (BuildContext conext) => AddUserGroupPage(),
        
      },
    );
  }
}
