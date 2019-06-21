import 'package:flutter/material.dart';

Widget confirmationText() {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 18, 12, 0),
      child: Text(
        "Is this the receipt you wish to upload?",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      )
    );
  }