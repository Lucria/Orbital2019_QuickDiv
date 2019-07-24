import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widget/manual_input_row.dart';

class ManualInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManualInputState();
  }
}

class _ManualInputState extends State<ManualInput> {
  final List<InputRow> _items = [];

  @override
  void initState() {
    _onAddRow();
    super.initState();
  }

  void _onAddRow() {
    setState(() {
      var _item = Item();
      Key key = UniqueKey();
      _items.add(InputRow(
        key: key,
        item: _item,
        onDelete: () => onDelete(_item),
      ));
    });
  }

  void onDelete(Item _item) {
    print(_items);

    setState(() {
      var find = _items.firstWhere(
        (it) => it.item == _item,
        orElse: () => null,
      );
      print('Removing: ' + find.toString());
      if (find != null) _items.removeAt(_items.indexOf(find));
    });
    print(_items);
    print(_items.length);
  }

  void onSave() {
    // if (_items.length > 0) {
    //   var allValid = true;
    //   _items.forEach((form) => allValid = allValid && form.isvalid());
    //   print(allValid);
    //   if (allValid) {
    //     var data = _items.map((it) => it.item).toList();
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         fullscreenDialog: true,
    //         builder: (_) => Scaffold(
    //           appBar: AppBar(
    //             title: Text('List of Users'),
    //           ),
    //           body: ListView.builder(
    //             addAutomaticKeepAlives: true,
    //             itemCount: data.length,
    //             itemBuilder: (_, i) => ListTile(
    //               leading: CircleAvatar(
    //                 child: Text(data[i].itemName.substring(0, 1)),
    //               ),
    //               title: Text(data[i].itemName),
    //               subtitle: Text(data[i].price.toString()),
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   }
    // }
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
            Expanded(
              child: ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index) {
                  return _items[index];
                },
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
