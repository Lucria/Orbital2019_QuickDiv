import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'dart:async';

class DetectionWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _DetectionWidgetState();
    }
}

class _DetectionWidgetState extends State<DetectionWidget> {

    // TODO pass image file from receipt_image page to here
//    File imageFile = getImageFile(); // * Placeholder
//    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
//    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
//    Future<VisionText> getVisionText() async {
//        VisionText visionText = await textRecognizer.processImage(visionImage);
//        return visionText;
//    }

    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("QuickDiv v1.0"),
            ),
        );
    }
}