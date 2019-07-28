import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
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
  List<String> _allNumber = [];
  String _message = 'QuickDiv \n\n';

  void _sendSMS(String message, List<String> recipents) async {
    String _result =
        await FlutterSms.sendSMS(message: message, recipients: recipents)
            .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  List<Widget> itemText(CustomContact contact) {
    List<Widget> v = [SizedBox(height: 10.0)];
    for (var a in contact.purchasedItem) {
      _message = _message + a.itemName + "\n";
      v.add(Text(a.itemName));
    }
    v.add(SizedBox(height: 10.0));
    _message = _message + "\n";
    return v;
  }

  Widget _inCard(CustomContact contact) {
    _message = _message + contact.totalOwed.toStringAsFixed(2) + ":\n";
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
            // decoration: BackgroundImage.myBoxDecoration(),
            padding: EdgeInsets.all(10.0),
            child: Container(
              child: ListView.builder(
                itemCount: model.selectedGroup.contacts.length,
                itemBuilder: (context, index) {
                  var _phoneList = model
                      .selectedGroup.contacts[index].contact.phones
                      .toList();
                  print(_phoneList[0].value);
                  _allNumber.add(_phoneList[0].value);
                  _message = _message +
                      model.selectedGroup.contacts[index].contact.displayName +
                      " - ";
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
            'Send to all via SMS'), // need reset the object to default state. for totalOwed and ListObject
        onPressed: () {
          GroupsModel model = ScopedModel.of(context);
          model.deselectGroup();
          print(_message);
          _sendSMS(_message, _allNumber);
          Navigator.popAndPushNamed(context, '/home');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
