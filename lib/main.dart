import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quickdiv_orbital2019/pages/review_page.dart';
import 'image_confirmation/receipt_image_upload.dart';
import 'image_confirmation/receipt_image_camera.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'pages/add_user_group.dart';
import 'class/custom_contacts.dart';
import 'pages/split_bill.dart';
import 'pages/review_page.dart';
import './ocr_related/ocr_test.dart';

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
  List<Map<String, List<CustomContact>>> _groups = [];
  File _imageFile;

  void _addGroups(Map<String, List<CustomContact>> groups) {
    print("[GroupManager Widget]  _addGroup()");
    setState(() {
      _groups.add(groups);
    });
    print(_groups);
  }

  // void _deleteProduct(int index) {
  //   setState(() {
  //     _groups.removeAt(index);
  //   });
  // }

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
        '/home': (BuildContext context) => MyHomePage(_groups),
        '/create': (BuildContext context) => AddUserGroupPage(_addGroups),
        '/splitbill': (BuildContext context) => SplitBill(),
        '/reviewpage': (BuildContext context) => ReviewPage(),
        '/ocrtest': (BuildContext context) => DetectionWidget(),
      },
    );
  }
}
