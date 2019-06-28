import 'package:flutter/material.dart';

class BackgroundImage {
  static myBoxDecoration() {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
        image: AssetImage('assets/background.jpg'),
      ),
    );
  }
}
