import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:flutter/material.dart';
import '../widget/groups/groups.dart';
import '../widget/ui_elements/background.dart';
import '../widget/ui_elements/appbar.dart';
import '../widget/show_model.dart';

class MyHomePage extends StatelessWidget {

  Widget oneTimeButton(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        heroTag: "oneTime",
        onPressed: () {
          // Bottom sheet will show two buttons
          // One button is for users to upload exisiting photos from gallery
          // The other button is for users to take a new photo using camera
          ShowModal.myModal(context); // Calling myModal function from the ShowModal class
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
      appBar: TitleText.defaultTitle(),
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
