import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import '../widget/background.dart';

class SplitBill extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplitBill();
  }
}

class _SplitBill extends State<SplitBill> {
  List<String> list = [
    'Item #1',
    'Item #2',
    'Item #3',
    'Item #4',
    'Item #5',
    'Item #6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QuickDiv'),
        actions: <Widget>[
          FlatButton(
            child: Text('Done'),
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/reviewpage');
            },
          )
        ],
      ),
      body: Container(
        decoration: BackgroundImage.myBoxDecoration(),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return itemCard(context, list[index], index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.undo),
        onPressed: () {},
      ),
    );
  }

  removeItem(int index) {
    setState(() {
      list.removeAt(index);
    });
  }

  Widget _shareDialog() {
    return AlertDialog(
      title: Text('Share'),
      actions: <Widget>[
        FlatButton(
          child: Text('Submit'),
          onPressed: () {},
        )
      ],
    );
  }

  Widget itemCard(BuildContext context, String name, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: SizedBox(
              height: 50,
              width: 50,
            ),
            title: Text(name.toString()),
            subtitle: Text('Price 1'),
            trailing: PopupMenuButton(
              onSelected: (value) {
                if (value == 'Share') {
                  _onAlertButtonPressed(context, index);
                } else {
                  print(value);
                  removeItem(value);
                }
              },
              itemBuilder: (context) {
                var list = List<PopupMenuEntry<Object>>();

                list.add(
                  PopupMenuItem(child: Text('Dillen'), value: index),
                );

                list.add(
                  PopupMenuItem(child: Text('Jerry'), value: index),
                );

                list.add(
                  PopupMenuItem(child: Text('Jon'), value: index),
                );

                list.add(
                  PopupMenuItem(child: Text('Pink'), value: index),
                );

                list.add(
                  PopupMenuItem(child: Text('Share'), value: 'Share'),
                );
                return list;
              },
            ),
          )
        ],
      ),
    );
  }

  _onAlertButtonPressed(context, index) {
    Alert(
      context: context,
      title: "Who are you sharing this item with? ",
      content: CheckboxGroup(
        labels: <String>[
          "Dillen",
          "Jerry",
          "Jon",
          "Pink",
          "Select All",
        ],
        onChange: (bool isChecked, String label, int index) {
          if (label == 'Select All') {}
          print("isChecked: $isChecked   label: $label  index: $index");
        },
        onSelected: (List<String> checked) =>
            print("checked: ${checked.toString()}"),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            removeItem(index);
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }
}
