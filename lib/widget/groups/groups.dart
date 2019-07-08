import 'package:flutter/material.dart';
import '../../class/custom_contacts.dart';
import './emptycontactswidget.dart';
import '../show_model.dart';
import '../../pages/add_user_group.dart';

class Groups extends StatelessWidget {
  final Function editGroup;
  final List<Map<String, List<CustomContact>>> groups;

  Groups(this.editGroup, this.groups) {
    print('[Groups widget] Constructor');
  }

  Widget _buildGroupContact(BuildContext context, int index) {
    String groupName = groups[index]
        .keys
        .toString()
        .substring(1, groups[index].keys.toString().length - 1);
    return GestureDetector(
      onTap: () {
        ShowModal.myModal(context);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.group,
                size: 35.0,
              ),
              title: Text(groupName),
              subtitle: Text('Description'),
              trailing: PopupMenuButton(
                onSelected: (value) {
                  print(value);
                  print('Card index: ' + index.toString());
                  print(groupName);

                  List<CustomContact> groupContact = groups[index][groupName];

                  // for (int i = 0; i < groupContact.length; i++) {
                  //   print(groupContact[i].contact.displayName);
                  //   print(groupContact[i].isChecked);
                  //   print(groupContact[i].contact.phones.elementAt(0).label +
                  //       ':' +
                  //       groupContact[i].contact.phones.elementAt(0).value);
                  // }

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddUserGroupPage(
                                editGroup: editGroup,
                                editContacts: groupContact,
                                index: index,
                                groupName: groupName,
                              )));
                },
                itemBuilder: (context) {
                  var list = List<PopupMenuEntry<Object>>();

                  list.add(
                    PopupMenuItem(
                        child: ListTile(
                            leading: Icon(Icons.edit), title: Text('Edit')),
                        value: 'edit'),
                  );

                  list.add(
                    PopupMenuItem(
                        child: ListTile(
                            leading: Icon(Icons.delete), title: Text('Delete')),
                        value: 'delete'),
                  );
                  return list;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupList() {
    Widget groupCards;
    if (groups.length > 0) {
      groupCards = ListView.builder(
        itemBuilder: _buildGroupContact,
        itemCount: groups.length,
      );
    } else {
      groupCards = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            emptyContactSection(),
          ],
        ),
      );
    }
    return groupCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[Group Widget] build()');
    return _buildGroupList();
  }
}
