import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:quickdiv_orbital2019/widget/ui_elements/background.dart';
import 'confirmation_message.dart';
import 'package:permission_handler/permission_handler.dart';
import '../ocr_related/ocr_test.dart';
import 'package:image_cropper/image_cropper.dart';

class UploadImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadImageState();
  }
}

class _UploadImageState extends State<UploadImage> {
  Future<File> imageFile;
  File image;
  File croppedFile;

  Future<File> pickImage(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
    return imageFile;
  }

  Future<Null> cropImage(File imageFile) async {
    croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      toolbarTitle: "Cropper",
      toolbarColor: Colors.blue,
      toolbarWidgetColor: Colors.white,
    );
  }

  void awaitCropt(File imageFile) async {
    await cropImage(imageFile);
    print("Cropped!");
  }

  Widget showImage() {
    return FutureBuilder<File> (
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          image = snapshot.data;
          awaitCropt(image);
          return Image.file(
            croppedFile, // ! Buggy! Need resolution
            width: 500,
            height: 500,
          );
        } else if (snapshot.error != null) {
          return const Text(
            "Error Picking Image",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return const Text(
            "No Image Selected",
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
  void initState() {
    super.initState();
    waitGalleryPermission();
  }

  @override
  Widget build(BuildContext context) {
//    pickImage(ImageSource.gallery);
    return Scaffold(
      // TODO Add AppBar to a seperate widget file
      appBar: AppBar(
        title: Text("QuickDiv v2.0"),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            child: Text('Next'),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetectionWidget(croppedFile))); // TODO Test OCR!
            },
          )
        ],
      ),
      body: Container(
        decoration: BackgroundImage.myBoxDecoration(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              showImage(),
              confirmationText(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getGalleryPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  void waitGalleryPermission() async {
    await getGalleryPermission();
    imageFile = pickImage(ImageSource.gallery);
  }
}
