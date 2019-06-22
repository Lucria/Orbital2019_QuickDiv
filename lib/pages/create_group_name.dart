import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import './custom_contacts.dart';

class CreateGroupName extends StatefulWidget {
  final List<CustomContact> contacts;

  CreateGroupName(this.contacts);

  @override
  State<StatefulWidget> createState() {
    return _CreateGroupName();
  }
}

class _CreateGroupName extends State<CreateGroupName> {
  String groupValue = '';

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
          title: Text('New Group'),
          actions: <Widget>[
            FlatButton(
                textColor: Colors.white,
                child: Text('Create'),
                onPressed: () {
                  print('Creating Groups with: ');
                  for (var i = 0; i < widget.contacts.length; i++) {
                    print(widget.contacts[i].contact.displayName);
                    print(widget.contacts[i].contact.phones.elementAt(0).label +
                        ':' +
                        widget.contacts[i].contact.phones.elementAt(0).value);
                  }
                }),
            // IconButton(
            //   icon: Icon(Icons.navigate_next, size: 35.0, textDirection:,),
            //   onPressed: (){},
            // )
          ],
        ),
        // body: Column(
          
        //   children: <Widget>[
        //     Expanded( ListView.builder(
        //       itemCount: widget.contacts.length,
        //       itemBuilder: (BuildContext context, int index) {
        //         CustomContact _contact = widget.contacts[index];
        //         var _phoneList = _contact.contact.phones.toList();

        //          _buildListTile(_contact,_phoneList);
        //       }),

        //     )
        //   ],
        // ),
        
        
        body: Container(
          child: ListView.builder(
              itemCount: widget.contacts.length,
              itemBuilder: (BuildContext context, int index) {
                CustomContact _contact = widget.contacts[index];
                var _phoneList = _contact.contact.phones.toList();

                return _buildListTile(_contact,_phoneList);
              }),
        ),
        // body: Container(
        //   margin: EdgeInsets.all(10.0),
        //   child: ListView(children: <Widget>[
        //     TextField(
        //       decoration: InputDecoration(
        //         labelText: 'Group Name',
        //       ),
        //       onChanged: (String value) {
        //         setState(() {
        //           groupValue = value;
        //         });
        //       },
        //     ),
        //     Container(
        //         child: ListView.builder(
        //       itemCount: widget.contacts.length,
        //       itemBuilder: (BuildContext context, int index) {
        //         CustomContact _contact = widget.contacts[index];
        //         var _phoneList = _contact.contact.phones.toList();

        //         return _buildListTile(_contact, _phoneList);
        //       },
        //     ))
        //   ]),
        // ),
      ),
    );
  }
}
