import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/custom_contacts.dart';
import '../../pages/add_user_group.dart';
import '../../scoped-models/groups_model.dart';
import '../show_model.dart';
import './emptycontactswidget.dart';

class Groups extends StatelessWidget {
  // Widget _buildGroupContact(BuildContext context, int index) {}

  Widget _buildGroupList(GroupsModel model) {
    Widget groupCards;
    if (model.groups.length > 0) {
      groupCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          String groupName = model.groups[index].groupName;
          List<CustomContact> groupContact = model.groups[index].contacts;

          return GestureDetector(
            onTap: () {
              print('GroupName: ' +
                  groupName +
                  'GroupIndex: ' +
                  index.toString());
              print('Group participant: ');

              for (int i = 0; i < groupContact.length; i++) {
                print(groupContact[i].contact.displayName);
                //   print(groupContact[i].isChecked);
                //   print(groupContact[i].contact.phones.elementAt(0).label +
                //       ':' +
                //       groupContact[i].contact.phones.elementAt(0).value);
              }
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
                        if (value == 'edit') {
                          print(value);
                          print('Card index: ' + index.toString());
                          print(groupName);
                          model.selectGroup(index);

                          Navigator.pushReplacementNamed(context, '/create');
                        } else if (value == 'delete') {
                          print('deleting at ' + index.toString());
                          model.selectGroup(index);
                          model.deleteGroup();
                        }
                      },
                      itemBuilder: (context) {
                        var list = List<PopupMenuEntry<Object>>();

                        list.add(
                          PopupMenuItem(
                              child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit')),
                              value: 'edit'),
                        );

                        list.add(
                          PopupMenuItem(
                              child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete')),
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
        },
        itemCount: model.groups.length,
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
    return ScopedModelDescendant<GroupsModel>(
      builder: (BuildContext context, Widget child, GroupsModel model) {
        return _buildGroupList(model);
      },
    );
  }
}
