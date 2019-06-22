import 'package:flutter/material.dart';
import './groups.dart';

class GroupManager extends StatelessWidget {
  final List<Map<String,dynamic>> groups;
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