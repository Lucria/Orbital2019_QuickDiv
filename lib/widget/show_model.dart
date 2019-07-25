import 'package:flutter/material.dart';

class ShowModal {
  static myModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ListTile(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, "/cameraimage"),
              leading: Icon(Icons.camera_enhance),
              title: Text("Take a new photo"),
              contentPadding: EdgeInsets.all(16),
            ),
            ListTile(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, "/existingimage"),
              leading: Icon(Icons.camera),
              title: Text("Upload from Gallery"),
              contentPadding: EdgeInsets.all(16),
            ),
            ListTile(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, "/manualinput"),
              leading: Icon(Icons.input),
              title: Text("Manually input your recipet"),
              contentPadding: EdgeInsets.all(16),
            ),
          ],
        );
      },
    );
  }
}
