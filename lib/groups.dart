import 'package:flutter/material.dart';
import 'pages/custom_contacts.dart';

class Groups extends StatelessWidget {
  final List<Map<String, List<CustomContact>>> groups;

  Groups(this.groups) {
    print('[Groups widget] Constructor');
  }

  Widget _buildGroupContact(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.group,
              size: 35.0,
            ),
            title: Text(groups[index]
                .keys
                .toString()
                .substring(1, groups[index].keys.toString().length - 1)),
            subtitle: Text('Description'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupList() {
    Widget groupCards;
    if (groups.length > 0) {
      groupCards = ListView.builder(
        itemBuilder: _buildGroupContact,
        itemCount: groups.length,
      );
    } else {
      groupCards = Center(
        child: Text(
            'Groups will appear here. \nPress the button below to get started!'),
      );
    }
    return groupCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[Product Widget] build()');
    return _buildGroupList();
  }
}