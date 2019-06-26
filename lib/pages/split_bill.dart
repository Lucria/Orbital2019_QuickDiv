import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return itemCard(list[index], index);
        },
      ),
    );
  }

  removeItem(int index) {
    setState(() {
      list.removeAt(index);
    });
  }

  Widget itemCard(String name, int index) {
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
                print(value);
                removeItem(value);
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
                  PopupMenuItem(child: Text('Share'), value: index),
                );
                return list;
              },
            ),
          )
        ],
      ),
    );
  }
}