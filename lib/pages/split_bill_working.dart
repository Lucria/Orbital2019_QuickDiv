import 'dart:io';
import 'dart:async';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  void initState() {
    super.initState();
    imageFile = widget.image;
  }

  Future readText() async {
    final FirebaseVisionImage ourImage =
        FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer recognizeText =
        FirebaseVision.instance.textRecognizer();
    final VisionText readText = await recognizeText.processImage(ourImage);
    recognizeText.close();
    // print(readText.text);

    // for (int i = 1; i < readText.blocks.length; i++) {
    //   print(i.toString() + ' ' + readText.blocks));
    // }
    for (TextBlock block in readText.blocks) {
      // print('1' + block.text);
      for (TextLine line in block.lines) {
        print(line.text);
        //   for (TextElement word in line.elements) {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    readText();
    return Scaffold(appBar: AppBar(title: Text('Divide your bill')));
  }
}