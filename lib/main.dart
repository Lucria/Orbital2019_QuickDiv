import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'image_confirmation/receipt_image_upload.dart';
import 'image_confirmation/receipt_image_camera.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'pages/add_user_group.dart';
import 'pages/split_bill.dart';
import 'pages/review_page.dart';
import './scoped-models/groups_model.dart';
import './pages/review_page.dart';

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
  @override
  Widget build(BuildContext context) {
    print("[main Widget] build()");

    return ScopedModel<GroupsModel>(
      model: GroupsModel(),
      child: MaterialApp(
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
          '/home': (BuildContext context) => MyHomePage(),
          '/create': (BuildContext context) => AddUserGroupPage(),
          '/splitbill': (BuildContext context) => SplitBill(),
          '/reviewpage': (BuildContext context) => ReviewPage(),
        },
      ),
    );
  }
}
