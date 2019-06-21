import 'package:flutter/material.dart';

class MyGallery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyGalleryState();
  }
}

class _MyGalleryState extends State<MyGallery> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QuickDiv v1.0"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.3, 0.5, 0.7, 0.9],
            colors: [
              Colors.indigo[300],
              Colors.indigo[100],
              Colors.pink[50],
              Colors.pink[100],
              Colors.pink[300],
            ],
          ),
        ),
      )
    );
  }
}