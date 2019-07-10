import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:flutter/material.dart';
import '../widget/groups/groups.dart';
import '../widget/background.dart';
import '../widget/show_model.dart';
import '../models/group.dart';

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
  final int _counter = 0;

  // Temporary function for testing
  void _incrementCounter() {
    // setState(() {
    //   _counter++;
    // });
    print(_counter);
  }

  Widget oneTimeButton(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        heroTag: "oneTime",
        onPressed: () {
          // Bottom sheet will show two buttons
          // One button is for users to upload exisiting photos from gallery
          // The other button is for users to take a new photo using camera
          ShowModal.myModal(context);
        },
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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      appBar: AppBar(
        title: Text("QuickDiv v1.0"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BackgroundImage.myBoxDecoration(),
        child: Groups(),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        fabButtons: <Widget>[
          oneTimeButton(context),
          createGroupButton(context),
        ],
        colorStartAnimation: Colors.deepPurple,
        colorEndAnimation: Colors.pink,
        // AnimatedIconData defines the start and end icons for the toggle animation
        animatedIconData: AnimatedIcons.menu_home,
      ),
    );
  }
}
