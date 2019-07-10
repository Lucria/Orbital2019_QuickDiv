import 'package:flutter/material.dart';
import './custom_contacts.dart';

class Group {
  final String groupName;
  final List<CustomContact> contacts;

  Group({
    @required this.groupName,
    @required this.contacts,
  });
}
