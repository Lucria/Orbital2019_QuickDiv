import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import '../class/custom_contacts.dart';

class CreateGroupName extends StatefulWidget {
  final Function addGroup;
  final Function editGroup;
  final int index;
  final String groupName;
  final List<CustomContact> contacts;

  CreateGroupName(this.contacts,
      {this.addGroup, this.editGroup, this.index, this.groupName});

  @override
  State<StatefulWidget> createState() {
    return _CreateGroupName();
  }
}

class _CreateGroupName extends State<CreateGroupName> {
  String _groupName = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ListTile _buildListTile(CustomContact c, List<Item> list) {
    return ListTile(
      leading: (c.contact.avatar != null)
          ? CircleAvatar(backgroundImage: MemoryImage(c.contact.avatar))
          : CircleAvatar(
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

  Widget _buildCreateGroupName() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Group Name',
        ),
        initialValue: widget.editGroup == null ? '' : widget.groupName,
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

  void _createGroup() {
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

    final Map<String, List<CustomContact>> group = {
      _groupName: widget.contacts
    };

    widget.addGroup(group);
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _editGroup() {
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

    final Map<String, List<CustomContact>> group = {
      _groupName: widget.contacts
    };

    widget.editGroup(widget.index, group);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('[CreateGroupName Widget] Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              widget.editGroup == null ? Text('New Group') : Text('Edit Group'),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: widget.editGroup == null ? Text('Create') : Text('Update'),
              onPressed: widget.editGroup == null ? _createGroup : _editGroup,
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildCreateGroupName(),
              _buildViewSelectedContact(),
            ],
          ),
        ),
      ),
    );
  }
}
