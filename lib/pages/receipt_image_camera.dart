import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickdiv_orbital2019/pages/split_bill.dart';
import '../widget/confirmation_message.dart';
import '../widget/ui_elements/background.dart';

class CameraImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CameraImageState();
  }
}

class _CameraImageState extends State<CameraImage> {
  File imageFile;
  File finalImage;
  Future<File> croppedFile;
  var state;

  Future<Null> pickImage(ImageSource source) async {
    imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      setState(() {
        state = "Captured" ;
      });
    }
  }

  Future<Null> cropImage() async {
    croppedFile = ImageCropper.cropImage(
      sourcePath: imageFile.path,
      toolbarTitle: "Cropper",
      toolbarColor: Colors.blue,
      toolbarWidgetColor: Colors.white,
    );
  }

  void initState() {
    super.initState();
    waitTakePhoto();
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: croppedFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          finalImage = snapshot.data;
          return Image.file(
            snapshot.data,
            width: 500,
            height: 500,
          );
        } else if (snapshot.error != null) {
          return Container(
              child: Text(
            "Error Picking Image",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ));
        } else {
          return Container(
              child: Text(
            "No Image Selected",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QuickDiv v2.0"),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            child: Text('Next'),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => SplitBill(image: finalImage,)
              ));
            },
          )
        ],
      ),
      body: Container(
        // decoration: BackgroundImage.myBoxDecoration(),
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

  void waitTakePhoto() async {
    await pickImage(ImageSource.camera);
    cropImage();
  }
}