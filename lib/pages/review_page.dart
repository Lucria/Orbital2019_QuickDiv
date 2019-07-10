import 'package:flutter/material.dart';
import '../widget/ui_elements/background.dart';
import '../widget/ui_elements/appbar.dart';

class ReviewPage extends StatelessWidget {

  
  Widget _inCard1() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.group,
              size: 35.0,
            ),
            title: Text('Arya'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text('Prawn Masala'),
                SizedBox(height: 10.0),
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: new BorderRadius.circular(8.0),
              ),
              child: Text(
                '\$10.00',
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

    Widget _inCard2() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.group,
              size: 35.0,
            ),
            title: Text('Daenerys'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text('Aloo Gopi Masala'),
                Text('Garlic Naan (Share with Jon)'),
                SizedBox(height: 10.0),
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: new BorderRadius.circular(8.0),
              ),
              child: Text(
                '\$8.40',
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

    Widget _inCard3() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.group,
              size: 35.0,
            ),
            title: Text('Jamie'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text('Butter Chicken Masala'),
                Text('Fresh Lime Sweet (Share with Tyrion)'),
                SizedBox(height: 10.0),
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: new BorderRadius.circular(8.0),
              ),
              child: Text(
                '\$10.50',
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

    Widget _inCard4() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.group,
              size: 35.0,
            ),
            title: Text('Jon'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text('Mushrrom 65'),
                Text('Garlic Naan (Share with Daenerys)'),
                SizedBox(height: 10.0),
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: new BorderRadius.circular(8.0),
              ),
              child: Text(
                '\$8.90',
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

    Widget _inCard5() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.group,
              size: 35.0,
            ),
            title: Text('Tyrion'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text('Onion Pakoda'),
                Text('Steamed Basmathi Rice'),
                Text('Fresh Lime Sweet (Share with Jamie)'),
                SizedBox(height: 10.0),
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: new BorderRadius.circular(8.0),
              ),
              child: Text(
                '\$10.50',
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
      appBar: TitleText.defaultTitle(),
      body: Container(
        decoration: BackgroundImage.myBoxDecoration(),
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            _inCard1(),
            _inCard2(),
            _inCard3(),
            _inCard4(),
            _inCard5(),
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
