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

  Map dataMap = Map<String, dynamic>.from(datav as Map);

  name = dataMap['name'];
  List<String> people = [];
  dataMap['people'].forEach((v) => people.add(v));

  //_playerPositions = Map<String, dynamic>.from(data as Map);
  var pictureLimit = dataMap['pictureLimit'];
  var pictureTakerIndex = dataMap['pictureTakerIndex'];
  var groupStarted = dataMap['groupStarted'];

  Group group = Group(
      id: id,
      name: name,
      people: people,
      pictureLimit: pictureLimit,
      groupStarted: groupStarted,
      pictureTakerIndex: pictureTakerIndex);

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
  late int pictureTakerIndex;

  Group({
    required this.id,
    required this.name,
    required this.groupStarted,
    required this.people,
    required this.pictureTakerIndex,
    this.isFinished = false,
    this.pictureLimit = 3,
  }) {
    refPeople = FirebaseDatabase.instance.ref().child('group/$id/people');
    refgroupStarted =
        FirebaseDatabase.instance.ref().child('group/$id/groupStarted');
    refGroup = FirebaseDatabase.instance.ref("group/$id");
  }

  addGroupToDatabase() async {
    //People me

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
    });

    refgroupStarted.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      startGroup(data);
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
    notifyListeners();
  }

  void startGroup(groupStatus) async {
    groupStarted = groupStatus;
    await refgroupStarted.set(groupStarted);
    await refGroup.update({"pictureTakerIndex": 0});

    notifyListeners();
  }

  void incrementPti() async {
    pictureTakerIndex += 1;

    notifyListeners();
  }
}
