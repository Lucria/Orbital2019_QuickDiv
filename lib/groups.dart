import 'package:flutter/material.dart';

class Groups extends StatelessWidget {
  final List<Map<String, dynamic>> groups;

  Groups(this.groups) {
    print('[Groups widget] Constructor');
  }

  Widget _buildGroupContact(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(groups[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () {},
                // onPressed: () => Navigator.pushNamed<bool>(
                //     context, '/product/' + index.toString()),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGroupList() {
    Widget groupCards; //Variable for this function
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
