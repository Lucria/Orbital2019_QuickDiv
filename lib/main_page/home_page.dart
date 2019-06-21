import 'package:flutter/material.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
//  This constructor declares 2 optional named parameters, optional named because of {}
//  First is of name key with type Key
//  Second is of name title with the type of the field this.title and automatically initializes this.title
//  with the passed value
//  : starts the initializer list. Initializer list allows some to execute some expressions before the call is
//  forwarded to the constructor of the super class
//  MyHomePage({Key key, this.title}) : super(key: key);
//   This class is the configuration for the state. It holds the values (in this
//   case the title) provided by the parent (in this case the App widget) and
//   used by the build method of the State. Fields in a Widget subclass are
//   always marked "final".
//
//  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // Temporary function for testing
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    print(_counter);
  }

  Widget oneTimeButton() {
    return Container(
      child: FloatingActionButton(
        heroTag: "oneTime",
        onPressed: () {
          // TODO Add bottom sheet with two buttons.
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context){
              return new Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new ListTile(
                    onTap: () => Navigator.pushReplacementNamed(context, '/gallery'),
                    leading: Icon(Icons.camera),
                    title: Text("Upload from Gallery"),
                    contentPadding: EdgeInsets.all(16),
                  ),
                  new ListTile(
                    onTap: () => print("Placeholder for taking new photo"),
                    leading: Icon(Icons.camera_enhance),
                    title: Text("Take a new photo"),
                    contentPadding: EdgeInsets.all(16),
                  ),
                ],
              );
            },
          );
          // ! One button for taking a new photo
          // ! One button for choosing from gallery
          // TODO Will change route to OCR page.
        },
        tooltip: "One-time usage button",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget createContactButton() {
    return Container(
        child: FloatingActionButton(
            heroTag: "createContact",
            onPressed: _incrementCounter,
            tooltip: "Create contact group button",
            child: Icon(Icons.assignment_ind)));
  }

  Widget emptyContactSection() {
    return Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "Groups added will appear here!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              "Press the button below to get started!",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
                color: Colors.black87,
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              emptyContactSection(),
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        fabButtons: <Widget>[
          oneTimeButton(),
          createContactButton(),
        ],
        colorStartAnimation: Colors.blue,
        colorEndAnimation: Colors.red,
        // AnimatedIconData defines the start and end icons for the toggle animation
        animatedIconData: AnimatedIcons.menu_close,
      ),
    );
  }
}
