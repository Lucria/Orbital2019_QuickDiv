import 'package:scoped_model/scoped_model.dart';
import '../models/group.dart';

class GroupsModel extends Model {
  List<Group> _groups = [];
  int _selectedGroupIndex;

  List<Group> get groups {
    // Getter function to get the private var
    return List.from(_groups);
  }

  int get selectedGroupIndex {
    return _selectedGroupIndex;
  }

  Group get selectedGroup {
    if (_selectedGroupIndex == null) {
      return null;
    }
    return _groups[_selectedGroupIndex];
  }

  void addGroups(Group group) {
    print("[GroupModel]  _addGroup()");
    _groups.add(group);
    _selectedGroupIndex = null;

    print('Added: ' + group.groupName + ' into _group list');
    print('_group list contain');
    for (int i = 0; i < _groups.length; i++) {
      print(_groups[i].groupName);
    }
  }

  void editGroup(Group group) {
    print("[GroupModel]  _editGroup()");
    print(_groups[_selectedGroupIndex]);
    _groups[_selectedGroupIndex] = group;
    _selectedGroupIndex = null;
  }

  void deleteGroup() {
    print("[GroupModel]  _deleteGroup()");
    _groups.removeAt(_selectedGroupIndex);
    _selectedGroupIndex = null;
    notifyListeners(); // Notify the state tree that the model have change so the widget need to change as well.
  }

  void selectGroup(int index) {
    _selectedGroupIndex = index;
  }
}
