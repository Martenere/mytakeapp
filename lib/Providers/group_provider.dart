import 'package:flutter/material.dart';

class GroupProvider with ChangeNotifier{
  String _groupId ='';
  String get groupId => _groupId;

void setGroupId(String groupId){
  _groupId = groupId;
  notifyListeners();
}
}