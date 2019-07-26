import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:validators/sanitizers.dart';
import 'package:validators/validators.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import '../models/item.dart';
import '../models/group.dart';
import '../pages/manual_input.dart';
import '../scoped-models/groups_model.dart';
import '../widget/ui_elements/background.dart';
import '../widget/ui_elements/groupcheckbox/groupcheckbox.dart';

class SplitBill extends StatefulWidget {
  final File image;
  SplitBill(this.image);

  @override
  State<StatefulWidget> createState() {
    return _SplitBill();
  }
}

class _SplitBill extends State<SplitBill> {
  List<String> itemNames = []; // To ensure that the list is growable
  List<String> itemPrices = [];
  List<String> itemQuantity = [];
  List<Item> _allItems = [];

  @override
  void initState() {
    waitReadText();
    super.initState();
  }

  void waitReadText() async {
    await readText();
  }

  removeItem(int index) {
    setState(() {
      _allItems.removeAt(index);
    });
  }

  Widget _shareDialog() {
    return AlertDialog(
      title: Text('Share'),
      actions: <Widget>[
        FlatButton(
          child: Text('Submit'),
          onPressed: () {},
        )
      ],
    );
  }

  Future readText() async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(widget.image);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText readText = await textRecognizer.processImage(visionImage);
    textRecognizer.close();
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        if (!isInt(line.text)) {
          // Check that it is NOT an integer
          if (isFloat(line.text)) {
            // Check that it is a float
            itemPrices
                .add(line.text); // Adds all price data to a list itemPrices
          } else {
            // Not an integer, split string into multiple substrings, check if first string is a number
            List<String> subStrings = line.text
                .split(" "); // Split line.text into multiple substrings
            if (isInt(subStrings[0])) {
              itemQuantity.add(subStrings[0]); // Add quantity to lists
              subStrings
                  .removeAt(0); // Remove quantity value from list of substrings
              String itemName =
                  subStrings.join(" "); // Concatenate everything together
              // print(itemName);
              itemNames.add(itemName); // Just want the item name
            }
          }
        }
      }
    }

    setState(() {
      var minLength = min(itemPrices.length, itemNames.length);
      for (var i = 0; i < minLength; i++) {
        _allItems.add(new Item(
            itemName: itemNames[i],
            price: toDouble(itemPrices[i]),
            qty: toInt(itemQuantity[i])));
      }
      for (var i in _allItems) {
        print(i.qty.toString() + " " + i.itemName + " " + i.price.toString());
      }
    });
    // print(itemPrices.length);
    // for (var i in itemPrices) {
    //   print(i);
    // }
    // print(itemNames.length);
    // for (var j in itemNames) {
    //   print(j);
    // }
    // print(itemQuantity.length);
    // for (var k in itemQuantity) {
    //   print(k);
    // }
  }

  Widget itemCard(
      BuildContext context, String name, String price, int index, Group group) {
    // print(group.groupName);
    // print(group.contacts.length);
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.fastfood,
              size: 45,
            ),
            title: Text(name.toString()),
            subtitle: Text(price.toString()),
            trailing: PopupMenuButton(
              onSelected: (value) {
                if (value == 'Share') {
                  _onAlertShareSheet(context, index, group);
                } else {
                  print(value);
                  removeItem(value);
                }
              },
              itemBuilder: (context) {
                var list = List<PopupMenuEntry<Object>>();

                for (int i = 0; i < group.contacts.length; i++) {
                  list.add(
                    PopupMenuItem(
                        child: ListTile(
                            leading: group.contacts[i].contact.avatar != null
                                ? CircleAvatar(
                                    backgroundImage: MemoryImage(
                                        group.contacts[i].contact.avatar),
                                  )
                                : CircleAvatar(child: Icon(Icons.person)),
                            title: Text(group.contacts[i].contact.displayName)),
                        value: index),
                  );
                }

                list.add(
                  PopupMenuItem(
                      child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.group),
                            backgroundColor:
                                Theme.of(context).toggleableActiveColor,
                          ),
                          title: Text('Share')),
                      value: 'Share'),
                );

                // list.add(
                //   PopupMenuItem(child: Text('Share'), value: 'Share'),
                // );
                return list;
              },
            ),
          )
        ],
      ),
    );
  }

  _onAlertShareSheet(context, index, Group group) {
    List<String> names = new List();
    List<String> selected = new List();

    group.contacts.forEach((group) => names.add(group.contact.displayName));
    names.add('Select all');

    Alert(
      context: context,
      title: "Who are you sharing this item with? ",
      content: GroupCheckbox(
        // my modifed version for select all
        labels: names,
        onChange: (bool isChecked, String label, int index) {
          if (label == 'Select All') {}
          print("isChecked: $isChecked   label: $label  index: $index");
        },
        onSelected: (List<String> checked) {
          print("checked: ${checked.toString()}");
          selected = checked;
        },
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (names.length == selected.length) selected.removeLast();
            print('Share with ' + selected.toString());

            removeItem(index);
            Navigator.pop(context);
          },
          color: Theme.of(context).toggleableActiveColor,
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Divide your bill'),
        actions: <Widget>[
          FlatButton(
            child: Text('Done'),
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/reviewpage');
            },
          )
        ],
      ),
      body: ScopedModelDescendant<GroupsModel>(
        builder: (BuildContext context, Widget child, GroupsModel model) {
          return Container(
            decoration: BackgroundImage.myBoxDecoration(),
            child: ListView.builder(
              itemCount: _allItems.length,
              itemBuilder: (context, index) {
                return itemCard(
                    context,
                    _allItems[index].itemName,
                    _allItems[index].price.toString(),
                    index,
                    model.selectedGroup);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ManualInput()));
        },
      ),
    );
  }
}
