import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/custom_contacts.dart';
import '../models/group.dart';
import '../scoped-models/groups_model.dart';

class CreateGroupName extends StatefulWidget {
  final List<CustomContact> contacts;

  CreateGroupName(this.contacts);

  @override
  State<StatefulWidget> createState() {
    return _CreateGroupName();
  }
}

class _CreateGroupName extends State<CreateGroupName> {
  String _groupName = '';
  bool _editing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ListTile _buildListTile(CustomContact c, List<Item> list) {
    return ListTile(
      leading: (c.contact.avatar != null)
          ? CircleAvatar(backgroundImage: MemoryImage(c.contact.avatar))
          : CircleAvatar(
              backgroundColor: Theme.of(context).toggleableActiveColor,
              child: Text(
                  (c.contact.displayName[0] +
                      c.contact.displayName[1].toUpperCase()),
                  style: TextStyle(color: Colors.white)),
            ),
      title: Text(c.contact.displayName ?? ""),
      subtitle: list.length >= 1 && list[0]?.value != null
          ? Text(list[0].value)
          : Text(''),
    );
  }

  Widget _buildCreateGroupName(Group group) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Group Name',
        ),
        initialValue: _editing == false ? '' : group.groupName,
        validator: (String value) {
          if (value.isEmpty) {
            print('Group name is empty');
            return 'Group name is empty.';
          }
          return null;
        },
        onSaved: (String value) {
          _groupName = value;
        },
      ),
    );
  }

  Widget _buildViewSelectedContact() {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.contacts.length,
          itemBuilder: (BuildContext context, int index) {
            CustomContact _contact = widget.contacts[index];
            var _phoneList = _contact.contact.phones.toList();

            return _buildListTile(_contact, _phoneList);
          }),
    );
  }

  void _createGroup(Function addGroup) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print('Creating ' + _groupName + ' Groups with: ');

    for (var i = 0; i < widget.contacts.length; i++) {
      print(widget.contacts[i].contact.displayName);
      print(widget.contacts[i].contact.phones.elementAt(0).label +
          ':' +
          widget.contacts[i].contact.phones.elementAt(0).value);
    }

    addGroup(Group(
      groupName: _groupName,
      contacts: widget.contacts,
    ));

    Navigator.pushNamedAndRemoveUntil(
        context, '/home', (Route<dynamic> route) => false);
  }

  void _editGroup(Function editGroup) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print('Creating ' + _groupName + ' Groups with: ');

    for (var i = 0; i < widget.contacts.length; i++) {
      print(widget.contacts[i].contact.displayName);
      print(widget.contacts[i].contact.phones.elementAt(0).label +
          ':' +
          widget.contacts[i].contact.phones.elementAt(0).value);
    }

    editGroup(Group(
      groupName: _groupName,
      contacts: widget.contacts,
    ));
    // Navigator.pushReplacementNamed(context, '/home');
    Navigator.pushNamedAndRemoveUntil(
        context, '/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      print('[CreateGroupName Widget] Back button pressed!');
      Navigator.pop(context, false);
      return Future.value(false);
    }, child: ScopedModelDescendant<GroupsModel>(
      builder: (BuildContext context, Widget child, GroupsModel model) {
        if (model.selectedGroup != null) {
          _editing = true;
        }

        return Scaffold(
          appBar: AppBar(
            title: _editing == false ? Text('New Group') : Text('Edit Group'),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                child: _editing == false ? Text('Create') : Text('Update'),
                onPressed: () {
                  _editing == false
                      ? _createGroup(model.addGroups)
                      : _editGroup(model.editGroup);
                },
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildCreateGroupName(model.selectedGroup),
                _buildViewSelectedContact(),
              ],
            ),
          ),
        );
      },
    ));
  }
}
