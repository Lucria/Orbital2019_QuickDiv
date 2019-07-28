import 'dart:io';
import 'dart:core';
import 'dart:math';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:validators/sanitizers.dart';
import 'package:validators/validators.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import '../models/item_object.dart';
import '../models/group.dart';
import '../pages/manual_input.dart';
import '../models/custom_contacts.dart';
import '../scoped-models/groups_model.dart';
import '../widget/ui_elements/background.dart';
import '../widget/ui_elements/groupcheckbox/groupcheckbox.dart';

class SplitBill extends StatefulWidget {
  final File image;
  final List<ItemObject> item;
  SplitBill({this.image, this.item});

  @override
  State<StatefulWidget> createState() {
    return _SplitBill();
  }
}

class _SplitBill extends State<SplitBill> {
  List<String> _itemNames = [];
  List<String> _itemPrices = [];
  List<String> _itemQuantity = [];
  List<ItemObject> _allItems = [];
  Map<ItemObject, List<CustomContact>> _splitBill = {};

  @override
  void initState() {
    if (widget.image != null)
      waitReadText();
    else {
      //Temporary fix for manual input. there is also a setstate in OCR function part
      _allItems = widget.item;
      _allItems.forEach((it) => _splitBill[it] = []);
    }
    super.initState();
  }

  void waitReadText() async {
    await readText();
  }

  void printShareItemList() {
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    _splitBill.forEach((k, v) {
      print('------------------------------');
      print(k.itemName + ": ");
      v.forEach((f) => print(f.contact.displayName));
    });
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
  }

  removeItem(String itemName, List<CustomContact> contact) {
    setState(() {
      _allItems.removeWhere((it) {
        if (it.itemName == itemName) {
          //Need to find an elgant of way print these stuff
          if (contact.length == 1) {
            _splitBill[it].add(contact[0]);
            printShareItemList();
          } else {
            for (var c in contact) {
              _splitBill[it].add(c);
            }
            printShareItemList();
          }
          return true;
        }
        return false;
      });
    });
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
            _itemPrices
                .add(line.text); // Adds all price data to a list _itemPrices
          } else {
            // Not an integer, split string into multiple substrings, check if first string is a number
            List<String> subStrings = line.text
                .split(" "); // Split line.text into multiple substrings
            if (isInt(subStrings[0])) {
              if (block.boundingBox.left < 200) {
                _itemQuantity.add(subStrings[0]); // Add quantity to lists
                subStrings.removeAt(
                    0); // Remove quantity value from list of substrings
                String itemName =
                    subStrings.join(" "); // Concatenate everything together
                // print(itemName);
                _itemNames.add(itemName); // Just want the item name
              }
            }
          }
        }
      }
    }

    setState(() {
      var minLength = min(_itemPrices.length, _itemNames.length);
      for (var i = 0; i < minLength; i++) {
        var item = ItemObject(
            itemName: _itemNames[i],
            price: toDouble(_itemPrices[i]),
            qty: toInt(_itemQuantity[i]));
        _allItems.add(item);

        _splitBill[item] = [];
      }
      if (minLength < _itemNames.length) {
        for (var i = minLength; i < _itemNames.length; i++) {
          var item = ItemObject(
            itemName: _itemNames[i],
            price: toDouble("99.99"),
            qty: toInt(_itemQuantity[i]),
          );
          _allItems.add(item);

          _splitBill[item] = [];
        }
      }
      for (var i in _allItems) {
        print(i.qty.toString() + " " + i.itemName + " " + i.price.toString());
      }
    });
    // print(_itemPrices.length);
    // for (var i in _itemPrices) {
    //   print(i);
    // }
    // print(_itemNames.length);
    // for (var j in _itemNames) {
    //   print(j);
    // }
    // print(_itemQuantity.length);
    // for (var k in _itemQuantity) {
    //   print(k);
    // }
  }

  Widget itemCard(BuildContext context, String itemName, double price,
      int index, Group group) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.fastfood,
              size: 45,
            ),
            title: Text(itemName.toString()),
            subtitle: Text(price.toStringAsFixed(2)),
            trailing: PopupMenuButton(
              onSelected: (selectedPerson) {
                if (selectedPerson == 'Share') {
                  _onAlertShareSheet(context, index, group, itemName);
                } else {
                  print(selectedPerson);
                  print('removing: ' + itemName);
                  print('puting it under: ' +
                      group.contacts[selectedPerson].contact.displayName);
                  List<CustomContact> _listContact = [];
                  _listContact.add(group.contacts[selectedPerson]);
                  removeItem(itemName, _listContact);
                }
              },
              itemBuilder: (context) {
                var list = List<PopupMenuEntry<Object>>();

                for (int i = 0; i < group.contacts.length; i++) {
                  //reset the state of user for totalowed and purchasedItem
                  /// Initailzie/clearing the list here. Which is a no go.
                  group.contacts[i].totalOwed = 0;
                  group.contacts[i].purchasedItem = [];

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
                        value: i),
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

                return list;
              },
            ),
          )
        ],
      ),
    );
  }

  void _shareDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please select 2 or more contact.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  _onAlertShareSheet(context, index, Group group, String itemName) {
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
            if (selected.length > 1) {
              if (names.length == selected.length) selected.removeLast();
              print('Share with ' + selected.toString());

              List<CustomContact> _listOfSelectedContact = [];
              group.contacts.forEach((f) {
                for (int i = 0; i < selected.length; i++) {
                  if (f.contact.displayName == selected[i]) {
                    _listOfSelectedContact.add(f);
                  }
                }
              });

              removeItem(itemName, _listOfSelectedContact);
              Navigator.pop(context);
            } else {
              _shareDialog();
            }
          },
          color: Theme.of(context).toggleableActiveColor,
          width: 120,
        )
      ],
    ).show();
  }

  Widget _nextFlatButton() {
    if (_allItems.length == 0) {
      return FlatButton(
        child: Text('Next'),
        textColor: Colors.white,
        onPressed: () {
          _splitBill.forEach((keyItem, valueAllContact) {
            print(keyItem.itemName);
            double itemObject = keyItem.price / valueAllContact.length;
            valueAllContact.forEach((customContact) {
              print(customContact.contact.displayName);
              customContact.totalOwed += itemObject;
              print(customContact.totalOwed.toString());
              customContact.purchasedItem.add(keyItem);
            });
            print('-----------------------------------');
          });

          Navigator.pushReplacementNamed(context, '/reviewpage');
        },
      );
    }
    return FlatButton(
      child: Text(''),
      onPressed: () {},
    );
  }

  Widget emptyContactSection() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "Please select next on the top right hand corner to proceede to the next page",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Divide your bill'),
        actions: <Widget>[
          _nextFlatButton(),
        ],
      ),
      body: ScopedModelDescendant<GroupsModel>(
        builder: (BuildContext context, Widget child, GroupsModel model) {
          return Container(
            // decoration: BackgroundImage.myBoxDecoration(),
            child: _allItems.length == 0
                ? emptyContactSection()
                : ListView.builder(
                    itemCount: _allItems.length,
                    itemBuilder: (context, index) {
                      return itemCard(context, _allItems[index].itemName,
                          _allItems[index].price, index, model.selectedGroup);
                    },
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManualInput(
                allItems: _allItems,
              ),
            ),
          );
        },
      ),
    );
  }
}
