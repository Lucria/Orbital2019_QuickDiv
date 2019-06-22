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

    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("QuickDiv v1.0"),
            ),
        );
    }
}