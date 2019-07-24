import 'package:flutter/material.dart';
import '../models/item.dart';

typedef OnDelete();

class InputRow extends StatefulWidget {
  final Item item;
  final state = _InputRowState();
  final OnDelete onDelete;

  InputRow({Key key, this.item, this.onDelete}) : super(key: key);

  @override
  _InputRowState createState() => state;

  bool isvalid() => state.validate();
}

class _InputRowState extends State<InputRow> {
  final form = GlobalKey<FormState>();

  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: widget.key,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) => widget.onDelete(),
      child: Form(
        key: form,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Expanded(
            //   flex: 1,
            //   child: IconButton(
            //     icon: Icon(Icons.delete),
            //     onPressed: widget.onDelete(),
            //   ),
            // ),
            Expanded(
              flex: 6,
              child: Container(
                margin: EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 5.0, bottom: 10.0),
                child: TextFormField(
                  validator: (val) =>
                      val.length > 1 ? null : 'Please enter the item name',
                  onSaved: (val) => widget.item.itemName = val,
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
                  validator: (val) =>
                      val.length > 1 ? null : 'Please enter the item price',
                  onSaved: (val) => widget.item.price = double.parse(val),
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(
                    top: 10.0, left: 5.0, right: 10.0, bottom: 10.0),
                child: TextFormField(
                  initialValue: widget.item.qty.toString(),
                  validator: (val) =>
                      val.length >= 1 ? null : 'Please enter the item qty',
                  onSaved: (val) => widget.item.qty = int.parse(val),
                  decoration: InputDecoration(
                    labelText: 'Qty',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
