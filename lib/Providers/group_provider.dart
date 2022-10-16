import 'package:flutter/material.dart';

import '../models/modelGroup.dart';

class GroupProvider with ChangeNotifier {
  String _groupId = '';
  late Group _group;

  Group get group => _group;
  String get groupId => _group.id;

  void setGroupId(String groupId) {
    _groupId = groupId;
    notifyListeners();
  }

  void setGroup(Group group) {
    _group = group;
    notifyListeners();
  }

}
