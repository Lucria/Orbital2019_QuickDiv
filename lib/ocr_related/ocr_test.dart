import 'package:mlkit/mlkit.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

class DetectionWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _DetectionWidgetState();
    }
}

class _DetectionWidgetState extends State<DetectionWidget> {

    FirebaseVisionTextDetector textDetector = FirebaseVisionTextDetector
        .instance;
    List<VisionText> currentTextLabels = <VisionText>[];

    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("QuickDiv v1.0"),
            ),
        );
    }
}