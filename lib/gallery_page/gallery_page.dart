import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MyGallery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyGalleryState();
  }
}

class _MyGalleryState extends State<MyGallery> {
  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    pickImageFromGallery(ImageSource.gallery);
    return Scaffold(
      appBar: AppBar(
        title: Text("QuickDiv v1.0"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.3, 0.5, 0.7, 0.9],
            colors: [
              Colors.indigo[300],
              Colors.indigo[100],
              Colors.pink[50],
              Colors.pink[100],
              Colors.pink[300],
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showImage(),
            ],
          ),
        ),
      ),
    );
  }
}