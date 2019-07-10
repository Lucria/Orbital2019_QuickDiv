import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:quickdiv_orbital2019/widget/ui_elements/background.dart';
import 'confirmation_message.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadImageState();
  }
}

class _UploadImageState extends State<UploadImage> {
  Future<File> imageFile;

  pickImage(ImageSource source) {
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
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/splitbill');
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
    Map<PermissionGroup,
      PermissionStatus> permissions = await PermissionHandler()
      .requestPermissions([PermissionGroup.storage]);
  }

  void waitGalleryPermission() async {
    await getGalleryPermission();
    pickImage(ImageSource.gallery);
  }
}