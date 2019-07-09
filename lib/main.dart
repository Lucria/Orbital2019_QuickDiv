import 'package:flutter/material.dart';
import 'package:quickdiv_orbital2019/pages/review_page.dart';
import 'image_confirmation/receipt_image_upload.dart';
import 'image_confirmation/receipt_image_camera.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'pages/add_user_group.dart';
import 'pages/split_bill.dart';
import 'pages/review_page.dart';
import './models/group.dart';

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
  List<Group> _groups = [];

  void _addGroups(Group group) {
    print("[GroupManager Widget]  _addGroup()");
    setState(() {
      _groups.add(group);
    });
    print(_groups);
  }

  void _editGroup(int index, Group group) {
    print("[GroupManager Widget]  _editGroup()");
    print(_groups[index]);
    setState(() {
      _groups[index] = group;
    });
  }

  void _deleteGroup(int index) {
    print("[GroupManager Widget]  _deleteGroup()");
    setState(() {
      _groups.removeAt(index);
    });
    print(_groups);
  }

  @override
  Widget build(BuildContext context) {
    print("[main Widget] build()");

    return MaterialApp(
      // debugShowMaterialGrid: true, // to show the grid of the layout.
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.pink,
          accentColor: Colors.blue[800]),
      debugShowCheckedModeBanner: false, //remove debug
      routes: {
        '/': (BuildContext context) => SplashScreen(),
        '/existingimage': (BuildContext context) => UploadImage(),
        '/cameraimage': (BuildContext context) => CameraImage(),
        '/home': (BuildContext context) =>
            MyHomePage(_editGroup, _deleteGroup, _groups),
        // MyHomePage(_addGroups, _editGroup, _groups),
        '/create': (BuildContext context) =>
            AddUserGroupPage(addGroup: _addGroups),
        '/splitbill': (BuildContext context) => SplitBill(),
        '/reviewpage': (BuildContext context) => ReviewPage(),
      },
    );
  }
}
