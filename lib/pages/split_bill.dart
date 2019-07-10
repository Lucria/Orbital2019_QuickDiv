import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import '../widget/ui_elements/background.dart';

class SplitBill extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplitBill();
  }
}

class _SplitBill extends State<SplitBill> {
  List<String> list = [
    'Prawn Masala',
    'Aloo Gopi Masala',
    'Butter Chicken Masala',
    'Mushrrom 65',
    'Onion Pakoda',
    'Steamed Basmathi Rice',
    'Garlic Naan',
    'Fresh Lime Sweet'
  ];
  List<String> price = [
    '\$10.00',
    '\$6.50',
    '\$9.00',
    '\$7.00',
    '\$5.50',
    '\$3.50',
    '\$3.80',
    '\$3.00'
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
            return itemCard(context, list[index], price[index], index);
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
      price.removeAt(index);
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

  Widget itemCard(BuildContext context, String name, String price, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.fastfood,
              size: 45,
            ),
            title: Text(name.toString()),
            subtitle: Text(price.toString()),
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
                  PopupMenuItem(
                      child: ListTile(
                          leading: Icon(Icons.person), title: Text('Arya')),
                      value: index),
                );

                list.add(
                  PopupMenuItem(
                      child: ListTile(
                          leading: Icon(Icons.person), title: Text('Daenerys')),
                      value: index),
                );

                list.add(
                  PopupMenuItem(
                      child: ListTile(
                          leading: Icon(Icons.person), title: Text('Jamie')),
                      value: index),
                );
                
                list.add(
                  PopupMenuItem(
                      child: ListTile(
                          leading: Icon(Icons.person), title: Text('Jon')),
                      value: index),
                );

                list.add(
                  PopupMenuItem(
                      child: ListTile(
                          leading: Icon(Icons.person), title: Text('Tyrion')),
                      value: index),
                );

                list.add(
                  PopupMenuItem(
                      child: ListTile(
                          leading: Icon(Icons.group), title: Text('Share')),
                      value: 'Share'),
                );
                

                // list.add(
                //   PopupMenuItem(child: Text('Share'), value: 'Share'),
                // );
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
          "Arya",
          'Daenerys',
          "Jamie",
          "Jon",
          "Tyrion",
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
