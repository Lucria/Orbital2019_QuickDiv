import 'package:flutter/material.dart';
import 'pages/custom_contacts.dart';
import './groups.dart';

class GroupManager extends StatelessWidget {
  final List<Map<String,List<CustomContact>>> groups;

  GroupManager(this.groups);

  @override
  Widget build(BuildContext context) {
    print('[GroupManager Widget] build()');
    return Column(
      children: <Widget>[
        Expanded(
          child: Groups(groups),
        )
      ],
    );
  }
}