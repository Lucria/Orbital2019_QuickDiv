import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'dart:async';

// TODO Complete this
class DetectionWidget extends StatefulWidget {
  final File image;
  DetectionWidget(this.image);

  @override
  State<StatefulWidget> createState() {
    return _DetectionWidgetState();
  }
}

class _DetectionWidgetState extends State<DetectionWidget> {
  File imageFile;
  FirebaseVisionImage visionImage;
  String results = "If you see this you are wrong";

  @override
  void initState() {
    super.initState();
    imageFile = widget.image;
    visionImage = FirebaseVisionImage.fromFile(imageFile);
  }

  Future<String> ocrText() async {
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);
    String newText = visionText.text;
    textRecognizer.close();
    return newText;
  }

  void saveText() async {
    results = await ocrText();
    print(results);
  }

  Future readText() async {
    final FirebaseVisionImage ourImage =
        FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer recognizeText =
        FirebaseVision.instance.textRecognizer();
    final VisionText readText = await recognizeText.processImage(ourImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          print(word.text);
        }
      }
    }
  }

  Widget build(BuildContext context) {
    // saveText();
    readText();
    return Scaffold(
      appBar: AppBar(
        title: Text("QuickDiv v1.0"),
      ),
      body: Container(child: Image.file(widget.image)),
    );
  }
}
