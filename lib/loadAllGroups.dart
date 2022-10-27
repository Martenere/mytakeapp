
import 'package:mytakeapp/models/modelGroup.dart';
import 'package:mytakeapp/models/modelPerson.dart';

class allGroups {

  Future<List<Group>> getGroupsfromFirebase(Person me) async {
    List<Group>groups  = [];
    for (var key in me.groups) {
      Group? group = await loadGroupFromFirebase(key);
      if (group == null){
        continue;
      }
      if (!groups.contains(group)) {
        groups.add(group);
      }
    }
    return groups;
  }
}
