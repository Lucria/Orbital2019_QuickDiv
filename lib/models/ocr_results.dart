import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class ImageOCR {
  File image;
  String results;
  // results = visionText.text;

  ImageOCR({
    this.image,
  });

  // Future<VisionText> getVisionText() async {
  //   VisionText visionText = await textRecognizer.processImage(visionImage);
  //   return visionText;
  // }
}