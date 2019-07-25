import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:validators/sanitizers.dart';
import 'package:validators/validators.dart';
import '../models/item.dart';

class SplitBill extends StatefulWidget {
  final File image;
  SplitBill(this.image);

  @override
  State<StatefulWidget> createState() {
    return _SplitBill();
  }
}

class _SplitBill extends State<SplitBill> {
  File imageFile;
  List<String> itemNames; // To ensure that the list is growable
  List<String> itemPrices;
  List<String> itemQuantity;
  List<Item> allItems;

  void initState() {
    super.initState();
    imageFile = widget.image;
    itemNames = new List();
    itemPrices = new List();
    itemQuantity = new List();
    allItems = new List();
  }

  Future readText() async {
    setState(() {
      itemNames = new List();
      itemPrices = new List();
      itemQuantity = new List();
      allItems = new List();
    });
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText readText = await textRecognizer.processImage(visionImage);
    textRecognizer.close();
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        if (!isInt(line.text)) { // Check that it is NOT an integer
          if (isFloat(line.text)) { // Check that it is a float
            itemPrices.add(line.text); // Adds all price data to a list itemPrices
          } else {  // Not an integer, split string into multiple substrings, check if first string is a number
            List<String> subStrings = line.text.split(" "); // Split line.text into multiple substrings
            if (isInt(subStrings[0])) {
              itemQuantity.add(subStrings[0]); // Add quantity to lists
              subStrings.removeAt(0); // Remove quantity value from list of substrings
              String itemName = subStrings.join(" "); // Concatenate everything together
              // print(itemName);
              itemNames.add(itemName); // Just want the item name
            }
          }
        } 
      }
    }
    var minLength = min(itemPrices.length, itemNames.length);
    for (var i = 0; i < minLength; i++) {
      allItems.add(new Item(itemName: itemNames[i], price: toDouble(itemPrices[i]), qty: toInt(itemQuantity[i])));
    }
    for (var i in allItems) {
      print(i.qty.toString() + " " + i.itemName + " " + i.price.toString());
    }
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

  @override
  Widget build(BuildContext context) {
    readText();
    return Scaffold(
      appBar: AppBar(
        title: Text('Divide your bill'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            child: Text('Next'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/existingimage');
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Image.file(imageFile),
        ],
      ),
    );
  }
}
