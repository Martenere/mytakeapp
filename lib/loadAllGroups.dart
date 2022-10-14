import 'package:firebase_database/firebase_database.dart';
import 'package:mytakeapp/models/modelGroup.dart';
import 'package:mytakeapp/models/modelPerson.dart';

class allGroups {
  List<Group> groups = [];

  Future<List<Group>> getGroupsfromFirebase(Person me) async {
    for (var key in me.groups) {
      Group group = await loadGroupFromFirebase(key);
      groups.add(group);
    }
    return groups;
  }
}
