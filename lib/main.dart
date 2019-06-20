import 'package:flutter/material.dart';
import './splashPage.dart';
import './homePage.dart';

import 'package:flutter/rendering.dart'; // to be delete - for debuging the widget lazyout.
void main() {
  // debugPaintSizeEnabled = true; // to view the rendering of the widget.
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true; // show where the tab event is registered. for tab listner.
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //inherite class from material.dart package
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    print("[main Widget] build()");

    return MaterialApp(
      // debugShowMaterialGrid: true, // to show the grid of the layout.
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.pink,
          accentColor: Colors.blueGrey),
          debugShowCheckedModeBanner: false, //remove debug LOL
      routes: {
        '/': (BuildContext context) => SplashScreen(),
        '/home': (BuildContext context) => HomePage(),
      },
    );
  }
}
