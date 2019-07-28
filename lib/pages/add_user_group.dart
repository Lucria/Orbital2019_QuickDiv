import 'dart:async';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scoped_model/scoped_model.dart';
import './create_group_name.dart';
import '../models/custom_contacts.dart';
import '../scoped-models/groups_model.dart';
import '../widget/ui_elements/background.dart';

class AddUserGroupPage extends StatefulWidget {
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
  bool _editting = false;
  PermissionStatus _status;

  TextEditingController editingController = TextEditingController();
  var items = List<CustomContact>();

  @override
  void initState() {
    super.initState();
    waitContactsPermission();
  }

  void waitContactsPermission() async {
    await getContactsPermission();
    refreshContacts();
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

    print('Selecting contact that are part of the group.');
    GroupsModel model = ScopedModel.of(context);

    if (model.selectedGroup != null) {
      print('Selected group name: ' + model.selectedGroup.groupName);
      print('part: ' + model.selectedGroup.contacts[0].contact.displayName);
      for (int i = 0; i < model.selectedGroup.contacts.length; i++) {
        for (int j = 0; j < _allContacts.length; j++) {
          // print("check: " + _allContacts[j].contact.displayName);
          // print("check: " + _allContacts[j].isChecked.toString());
          if (_allContacts[j].contact.displayName ==
              model.selectedGroup.contacts[i].contact.displayName) {
            _allContacts[j].isChecked = true;
            // print("found: " + _allContacts[j].contact.displayName);
            // print("check: " + _allContacts[j].isChecked.toString());
            break;
          }
        }
      }
      _editting = true;
    }

    items.addAll(_allContacts);
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

  ListTile _buildListTile(
      CustomContact c, List<Item> list, BuildContext context) {
    bool _load =
        Theme.of(context).platform == TargetPlatform.iOS ? true : false;
    // print(c.contact.displayName);
    // print(c.isChecked);

    return ListTile(
      leading: (_load) // if true load ios code else android code
          ? loadAvatar(c, (c.contact.avatar != null))
          : loadAvatar(c, (c.contact.avatar.isNotEmpty)),
      title: Text(c.contact.displayName ?? ""),
      subtitle: list.length >= 1 && list[0]?.value != null
          ? Text(list[0].value)
          : Text(''),
      trailing: Checkbox(
          activeColor: Theme.of(context).toggleableActiveColor,
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
            backgroundColor: Theme.of(context).toggleableActiveColor,
            child: Text(
                (c.contact.displayName[0] +
                    c.contact.displayName[1].toUpperCase().toString()),
                style: TextStyle(color: Colors.white)),
          );
  }

  void dialog(String title, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text('Dimiss'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  void _onSubmit() {
    print('Next Button Pressed');
    _selectedContacts =
        _allContacts.where((contact) => contact.isChecked == true).toList();

    if (_selectedContacts.length == 0) {
      print('0 contact la');
      dialog('Alert!', 'No contact selected.');
      return;
    } else if (_selectedContacts.length == 1) {
      print('please select 2 or more contact');
      dialog('Alert!', 'Please select 2 or more contact.');
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateGroupName(_selectedContacts)));
  }

  void filterSearchResults(String query) {
    List<CustomContact> dummySearchList = List<CustomContact>();
    dummySearchList.addAll(_allContacts);
    print('querying:' + query);
    print('query length: ' + query.length.toString());
    if (query.isNotEmpty) {
      List<CustomContact> dummyListData = List<CustomContact>();
      dummySearchList.forEach((item) {
        if (item.contact.displayName
            .toLowerCase()
            .contains(query.toLowerCase())) {
          print('searching for matching string in earch contact');
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(_allContacts);
        print('_allContacts');
      });
    }
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
          title: _editting == false
              ? Text('Add Participants')
              : Text('Edit Group'),
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
                // decoration: BackgroundImage.myBoxDecoration(),
                child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                        alignment: Alignment(1.0, 1.0),
                        children: <Widget>[
                          TextField(
                            onChanged: (value) {
                              filterSearchResults(value);
                            },
                            controller: editingController,
                            decoration: InputDecoration(
                                labelText: "Search",
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0)))),
                          ),
                          editingController.text.length > 0
                              ? IconButton(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      editingController.clear();
                                      filterSearchResults('');
                                    });
                                  })
                              : Container(
                                  height: 0.0,
                                )
                        ]),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items?.length,
                      itemBuilder: (BuildContext context, int index) {
                        CustomContact _contact = items[index];
                        var _phonesList = _contact.contact.phones.toList();

                        return _buildListTile(_contact, _phonesList, context);
                      },
                    ),
                  ),
                ],
              ))
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
