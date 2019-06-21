import 'package:flutter/material.dart';

Widget confirmationText() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        "Is this the receipt you wish to upload?",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      )
    );
  }