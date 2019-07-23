import 'package:flutter/material.dart';
import '../models/item.dart';

class InputRow extends StatefulWidget {
  final Item item;

  InputRow({Key key, this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InputRowState();
  }
}

class _InputRowState extends State<InputRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              margin: EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 5.0, bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Item name',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(
                  top: 10.0, left: 5.0, right: 5.0, bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(
                  top: 10.0, left: 5.0, right: 10.0, bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Qty',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
