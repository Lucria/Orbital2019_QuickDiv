import 'package:flutter/material.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import '../group_manager.dart';
import './custom_contacts.dart';

class MyHomePage extends StatelessWidget {
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
  // final String groupName;
  // final CustomContact contact;
  final List<Map<String,List<CustomContact>>> groups;

  MyHomePage(this.groups);

  final int _counter = 0;

  // Temporary function for testing
  void _incrementCounter() {
    // setState(() {
    //   _counter++;
    // });
    print(_counter);
  }

  Widget oneTimeButton() {
    return Container(
      child: FloatingActionButton(
        heroTag: "oneTime",
        onPressed: _incrementCounter,
        tooltip: "One-time usage button",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget createGroupButton(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        heroTag: "createContact",
        onPressed: () {
          print('[home_page] trigger createContactButton()');
          Navigator.pushNamed(context, '/create');
        },
        tooltip: "Create contact group button",
        child: Icon(Icons.assignment_ind),
      ),
    );
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
                "Contacts added will appear here!",
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
        automaticallyImplyLeading: false,
      ),
      body: GroupManager(groups),

      // Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topRight,
      //     end: Alignment.bottomLeft,
      //     stops: [0.1, 0.3, 0.5, 0.7, 0.9],
      //     colors: [
      //       Colors.indigo[300],
      //       Colors.indigo[100],
      //       Colors.pink[50],
      //       Colors.pink[100],
      //       Colors.pink[300],
      //     ],
      //   ),
      // ),
      // child: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       // emptyContactSection(),
      //     ],
      //   ),
      // ),
      // ),
      floatingActionButton: AnimatedFloatingActionButton(
        fabButtons: <Widget>[
          oneTimeButton(),
          createGroupButton(context),
        ],
        colorStartAnimation: Colors.blue,
        colorEndAnimation: Colors.red,
        // AnimatedIconData defines the start and end icons for the toggle animation
        animatedIconData: AnimatedIcons.menu_close,
      ),
    );
  }
}
