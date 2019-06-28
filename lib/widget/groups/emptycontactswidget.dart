import 'package:flutter/material.dart';

Widget emptyContactSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "Groups added will appear here!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            "Press the button below to get started!",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 18,
              color: Colors.black87,
            ),
          )
        ],
      )
    );
  }