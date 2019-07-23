import 'package:flutter/material.dart';
import '../widget/ui_elements/appbar.dart';

class ManualInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManualInputState();
  }
}

Widget _inputRow() {
  return Container(
      child: Row(
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Container(
          margin:
              EdgeInsets.only(top: 10.0, left: 10.0, right: 5.0, bottom: 10.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Item name',
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          margin:
              EdgeInsets.only(top: 10.0, left: 5.0, right: 10.0, bottom: 10.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Price',
            ),
          ),
        ),
      ),
    ],
  ));
}

class _ManualInputState extends State<ManualInput> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('[ManualInput] Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: TitleText.defaultTitle(),
        body: Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return _inputRow();
              },
            ),
          ],
        ),
      ),
    );
  }
}
