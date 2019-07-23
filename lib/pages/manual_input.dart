import 'package:flutter/material.dart';
import '../widget/ui_elements/appbar.dart';
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

  void _onAddRow() {
    setState(() {
      var _item = Item();
      _items.add(InputRow(key: UniqueKey(), item: _item));
    });
  }

  void onDelete(Key _item) {
    setState(() {
      _items.removeWhere((item) => item.key == _item);
    });
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
        appBar: TitleText.defaultTitle(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: _items[index].key,
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
                        onDelete(_items[index].key),
                    child: _items[index],
                  );
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
