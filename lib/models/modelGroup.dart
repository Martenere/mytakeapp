import 'package:flutter/material.dart';
import 'package:mytakeapp/firebase/firebaseDatabase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mytakeapp/id_retriever.dart';
import 'modelPerson.dart';

Future<Group> loadGroupFromFirebase(String id) async {
  DatabaseReference refGroup = await FirebaseDatabase.instance.ref("group/$id");
  DataSnapshot data = await refGroup.get();
  var datav = data.value;

  var name = (data.child('name').value as String);
  print("Children:");
  Map dataMap = Map<String, dynamic>.from(datav as Map);
  print(dataMap);
  name = dataMap['name'];
  List<String> people = [];
  dataMap['people'].forEach((v) => people.add(v));
  print(people);

  //_playerPositions = Map<String, dynamic>.from(data as Map);
  var pictureLimit = dataMap['pictureLimit'];
  var groupStarted = dataMap['groupStarted'];

  Group group = Group(
      id: id,
      name: name,
      people: people,
      pictureLimit: pictureLimit,
      groupStarted: groupStarted);

  group.startListening();

  return group;
}

class Group with ChangeNotifier {
  late String id;
  String name;
  List<String> people;
  bool groupStarted;

  bool isFinished;
  int pictureLimit;
  late FirebaseGroup _fbd;
  late var refPeople;
  late var refgroupStarted;
  late var refGroup;

  Group(
      {required this.id,
      required this.name,
      required this.groupStarted,
      required this.people,
      this.isFinished = false,
      this.pictureLimit = 3}) {
    refPeople = FirebaseDatabase.instance.ref().child('group/$id/people');
    refgroupStarted =
        FirebaseDatabase.instance.ref().child('group/$id/groupStarted');
    refGroup = FirebaseDatabase.instance.ref("group/$id");
  }

  addGroupToDatabase() async {
    //People me
    print("Added $name to DB");
    // print(people[0].name);
    await refGroup.set({
      'id': id,
      'name': name,
      'people': people,
      'pictureLimit': pictureLimit,
      'groupStarted': false
    });

    //database event listener - listen to people added or removed
    startListening();
  }

  void startListening() {
    refPeople.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      eventUpdatePeopleList(data);
      print("$data was recived from listener");
    });

    refgroupStarted.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      startGroup(data);
      print("$data startedSession $name");
    });
  }

  void addPerson(Person person) {
    if (!people.contains(person.id)) {
      people.add(person.id);
    }
    refPeople.set(people);
  }

  void eventUpdatePeopleList(data) {
    people = []; //empty data in people list

    for (String p in data) {
      // add people from recieved data
      people.add(p);
    }
    print("event updatepoeple list : $people");
    notifyListeners();
  }

  void startGroup(data) async {
    groupStarted = data;
    await refgroupStarted.set(groupStarted);
    notifyListeners();
  }
}
