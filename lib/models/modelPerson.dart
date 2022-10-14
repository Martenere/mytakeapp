import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Person with ChangeNotifier {
  String id;
  String name;
  late var color;
  List<String> groups = [];
  bool dataLoaded = false;

  late DatabaseReference refMe;

  Person({required this.id, this.name = "Ada"}) {
    //unpack data
    color = Colors.blue;
    refMe = FirebaseDatabase.instance.ref().child('people/$id');
    loadDataFromFirebase();
  }

  loadDataFromFirebase() async {
    DataSnapshot data = await refMe.get();
    if (data.exists) {
      name = data.child('name').value.toString();
      color = data.child('color').value; //fråga olof om detta, får tbax object?

      var datav = data.value;
      groups = [];
      Map dataMap = Map<String, dynamic>.from(datav as Map);

      if (dataMap['groups'] != null) {
        dataMap['groups'].forEach((v) => groups.add(v));
      }

      dataLoaded = true;
    } else {
      refMe.set({'name': 'Jacob', 'color': 'blue', 'groups': []});
    }
  }

  addGroup(String groupId) {
    if (!groups.contains(groupId)) {
      groups.add(groupId);
      refMe.update({'groups': groups});
    }
    notifyListeners();
  }

  removeGroup(String groupId) {
    groups.remove(groupId);
    refMe.update({'groups': groups});
    notifyListeners();
  }
}
