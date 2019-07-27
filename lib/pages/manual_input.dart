import 'package:flutter/material.dart';
import '../models/item_object.dart';

class ManualInput extends StatefulWidget {
  final List<ItemObject> allItems;

  ManualInput({this.allItems});
  @override
  State<StatefulWidget> createState() {
    return _ManualInputState();
  }
}

class _ManualInputState extends State<ManualInput> {
  final _formKey = GlobalKey<FormState>();
  final List<ItemObject> _items = [];

  bool validate() {
    var valid = _formKey.currentState.validate();
    if (valid) _formKey.currentState.save();
    return valid;
  }

  @override
  void initState() {
    if (widget.allItems != null) {
      for (var i in widget.allItems) {
        _items
            .add(ItemObject(itemName: i.itemName, price: i.price, qty: i.qty));
      }
    } else {
      _onAddRow();
    }
    super.initState();
  }

  void _onAddRow() {
    setState(() {
      _items.add(ItemObject());
    });
  }

  void onDelete(ItemObject item) {
    setState(() {
      _items.remove(item);
    });
  }

  void onSave() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    print('form saved');
    _formKey.currentState.save();

    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text('Output'),
          ),
          body: ListView.builder(
            addAutomaticKeepAlives: true,
            itemCount: _items.length,
            itemBuilder: (_, i) => ListTile(
              title: Text(_items[i].itemName +
                  "," +
                  _items[i].price.toString() +
                  "," +
                  _items[i].qty.toString()),
            ),
          ),
        ),
      ),
    );
  }

  Row _inputRow(ItemObject item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Container(
            margin: EdgeInsets.only(
                top: 10.0, left: 10.0, right: 5.0, bottom: 10.0),
            child: TextFormField(
              initialValue: item.itemName,
              validator: (val) =>
                  val.length > 1 ? null : 'Please enter the item name',
              onSaved: (val) => item.itemName = val,
              decoration: InputDecoration(
                labelText: 'Item name',
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin:
                EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0, bottom: 10.0),
            child: TextFormField(
              initialValue: item.price.toString(),
              validator: (val) =>
                  val.length > 1 ? null : 'Please enter the item price',
              onSaved: (val) => item.price = double.parse(val),
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
              initialValue: item.qty.toString(),
              validator: (val) =>
                  val.length >= 1 ? null : 'Please enter the item qty',
              onSaved: (val) => item.qty = int.parse(val),
              decoration: InputDecoration(
                labelText: 'Qty',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: false),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('[ManualInput] Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manual Entry'),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: Text('Next'),
              onPressed: onSave,
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Expanded(
                child: ListView.builder(
                  addAutomaticKeepAlives: true,
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: Key(_items[index].hashCode.toString()),
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
                      onDismissed: (DismissDirection direction) =>
                          onDelete(_items[index]),
                      child: _inputRow(_items[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _onAddRow,
        ),
      ),
    );
  }
}
