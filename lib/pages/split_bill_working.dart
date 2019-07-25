import 'dart:io';
import 'dart:async';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  List<String> itemNames = new List(); // To ensure that the list is growable
  List<String> itemPrices = new List();
  List<Item> allItems = new List();

  void initState() {
    super.initState();
    imageFile = widget.image;
  }

  Future readText() async {
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
          }
        }
      }
    }
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
