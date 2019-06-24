import 'dart:async';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import '../class/custom_contacts.dart';
import 'create_group_name.dart';

class AddUserGroupPage extends StatefulWidget {
  final Function addGroup;

  AddUserGroupPage(this.addGroup);

  @override
  State<StatefulWidget> createState() {
    return _AddUserGroupPage();
  }
}

class _AddUserGroupPage extends State<AddUserGroupPage> {
  List<Contact> _contacts = new List<Contact>();
  List<CustomContact> _selectedContacts = List<CustomContact>();
  List<CustomContact> _allContacts = List<CustomContact>();
  bool _isLoading = false;
  PermissionStatus _status;

  @override
  void initState() {
    super.initState();
    waitContactsPermission();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // WillPopScope will listen to the back button being press - for Android only.
      onWillPop: () {
        print('[AddUserGroupPage] Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Participants'),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: Text('Next'),
              onPressed: _onSubmit,
            )
          ],
        ),
        body: !_isLoading
            ? Container(
                child: ListView.builder(
                  itemCount: _selectedContacts?.length,
                  itemBuilder: (BuildContext context, int index) {
                    CustomContact _contact = _selectedContacts[index];
                    var _phonesList = _contact.contact.phones.toList();

                    return _buildListTile(_contact, _phonesList, context);
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  void _onSubmit() {
    print('Create Button Pressed');
    _selectedContacts =
        _allContacts.where((contact) => contact.isChecked == true).toList();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CreateGroupName(widget.addGroup, _selectedContacts)));
  }

  ListTile _buildListTile(
      CustomContact c, List<Item> list, BuildContext context) {
    bool _load =
        Theme.of(context).platform == TargetPlatform.iOS ? true : false;

    return ListTile(
      leading: (_load) // if true load ios code else android code
          ? loadAvatar(c, (c.contact.avatar != null))
          : loadAvatar(c, (c.contact.avatar.isNotEmpty)),
      title: Text(c.contact.displayName ?? ""),
      subtitle: list.length >= 1 && list[0]?.value != null
          ? Text(list[0].value)
          : Text(''),
      trailing: Checkbox(
          activeColor: Colors.green,
          value: c.isChecked,
          onChanged: (bool value) {
            setState(() {
              c.isChecked = value;
            });
          }),
    );
  }

  Widget loadAvatar(CustomContact c, bool contactAvatar) {
    return contactAvatar
        ? CircleAvatar(backgroundImage: MemoryImage(c.contact.avatar))
        : CircleAvatar(
            child: Text(
                (c.contact.displayName[0] +
                    c.contact.displayName[1].toUpperCase().toString()),
                style: TextStyle(color: Colors.white)),
          );
  }

  refreshContacts() async {
    setState(() {
      _isLoading = true;
    });
    var contacts = await ContactsService.getContacts();
    _populateContacts(contacts);
  }

  void _populateContacts(Iterable<Contact> contacts) {
    _contacts = contacts.where((item) => item.displayName != null).toList();
    _contacts.sort((a, b) => a.displayName.compareTo(b.displayName));
    _allContacts =
        _contacts.map((contact) => CustomContact(contact: contact)).toList();
    setState(() {
      _selectedContacts = _allContacts;
      _isLoading = false;
    });
  }

  Future<void> getContactsPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.contacts]);
    _status = permissions[PermissionGroup.contacts];
  }

  void waitContactsPermission() async {
    await getContactsPermission();
    refreshContacts();
  }
}
