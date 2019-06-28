import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  Widget _inCard() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.group,
              size: 35.0,
            ),
            title: Text('Test'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text('Item 1'),
                Text('Item 2'),
                Text('Item 3'),
                SizedBox(height: 10.0),
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: new BorderRadius.circular(8.0),
              ),
              child: Text(
                '\$1000',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QuickDiv'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            _inCard(),
            _inCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.send),
        label: Text('Send to all'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
