import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'dart:async';
import '../models/ocr_results.dart';

// TODO Complete this
class DetectionWidget extends StatefulWidget {
  DetectionWidget(this._imageOCR);
  final ImageOCR _imageOCR;

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
    imageFile = widget._imageOCR.image;
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

  Widget build(BuildContext context) {
    // saveText();
    return Scaffold(
      appBar: AppBar(
        title: Text("QuickDiv v1.0"),
      ),
    );
  }
}