import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseGroup {
  String id;
  FirebaseGroup(this.id);

  late FirebaseDatabase database;
  late DatabaseReference ref;
  late DatabaseReference refGroup;
  late DatabaseReference refPeople;

  void initGroup(String groupId) async {
    database = FirebaseDatabase.instance;
    ref = FirebaseDatabase.instance.ref();

    refGroup = FirebaseDatabase.instance.ref("group/$groupId");
    refPeople = refGroup.child("people");
    // refPeople.onValue.listen((DatabaseEvent event) {
    //   final data = event.snapshot.value;
    //   print("$data was recived from listener");
    // });
  }

  addGroupToDatabase(
    String name,
  ) async {
    //People me
    print("Added $name to DB");
    await refGroup.set({'id': id, 'name': name});
  }
}
