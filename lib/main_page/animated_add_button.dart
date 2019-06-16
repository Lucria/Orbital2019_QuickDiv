import 'package:flutter/material.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';

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
  }

  Widget oneTimeButton() {
    return Container(
      child: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: "One-time usage button",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget createContactButton() {
    return Container(
        child: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: "Create contact group button",
            child: Icon(Icons.assignment_ind)));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.

    return Scaffold(
      appBar: AppBar(
          title: Text("QuickDiv v1.0"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              // This code portion defines text style of _counter
              style: Theme.of(context).textTheme.display1,
            ),
          ],
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
