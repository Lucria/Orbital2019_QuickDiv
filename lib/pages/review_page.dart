import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/custom_contacts.dart';
import '../widget/ui_elements/appbar.dart';
import '../scoped-models/groups_model.dart';
import '../widget/ui_elements/background.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReviewPageState();
  }
}

class _ReviewPageState extends State<ReviewPage> {
  List<Widget> itemText(CustomContact contact) {
    List<Widget> v = [SizedBox(height: 10.0)];
    for (var a in contact.purchasedItem) {
      v.add(Text(a.itemName));
    }
    v.add(SizedBox(height: 10.0));
    return v;
  }

  Widget _inCard(CustomContact contact) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: contact.contact.avatar != null
                ? CircleAvatar(
                    backgroundImage: MemoryImage(contact.contact.avatar),
                  )
                : CircleAvatar(child: Icon(Icons.person)),
            title: Text(contact.contact.displayName),
            subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: itemText(contact)),
            trailing: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: new BorderRadius.circular(8.0),
              ),
              child: Text(
                contact.totalOwed.toStringAsFixed(2),
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
      body: ScopedModelDescendant<GroupsModel>(
        builder: (BuildContext context, Widget child, GroupsModel model) {
          return Container(
            decoration: BackgroundImage.myBoxDecoration(),
            padding: EdgeInsets.all(10.0),
            child: Container(
              child: ListView.builder(
                itemCount: model.selectedGroup.contacts.length,
                itemBuilder: (context, index) {
                  return _inCard(model.selectedGroup.contacts[index]);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.send),
        label: Text(
            'Send to all'), // need reset the object to default state. for totalOwed and ListObject
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
