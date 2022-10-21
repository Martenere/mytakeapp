import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mytakeapp/firebase/firebaseDatabase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mytakeapp/id_retriever.dart';
import 'modelPerson.dart';

Future<Group?> loadGroupFromFirebase(String id) async {
  DatabaseReference refGroup = await FirebaseDatabase.instance.ref("group/$id");
  DataSnapshot data = await refGroup.get();
  if (!data.exists) {
    print("$id that group doesn't exist");
    return null;
  }
  var datav = data.value;
  print(" group id $id");
  print(datav);
  var name = (data.child('name').value as String);

  Map dataMap = Map<String, dynamic>.from(datav as Map);

  name = dataMap['name'];
  List<String> people = [];
  dataMap['people'].forEach((v) => people.add(v));

  //_playerPositions = Map<String, dynamic>.from(data as Map);
  var pictureLimit = dataMap['pictureLimit'];
  var pictureTakerIndex = dataMap['pictureTakerIndex'] ?? 0;
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

  late DatabaseReference refPeople;
  late DatabaseReference refgroupStarted;
  late DatabaseReference refGroup;
  late DatabaseReference refPictureTaker;
  late DatabaseReference refPrompt;

  late int pictureTakerIndex;

  Future<String> get previousPictureTaker =>
      getNameFromId(people[(pictureTakerIndex - 1) % people.length]);

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
    refPictureTaker =
        FirebaseDatabase.instance.ref().child('group/$id/pictureTakerIndex');
    refGroup = FirebaseDatabase.instance.ref("group/$id");
    refPrompt = refGroup.child("textPrompt");
  }

  addGroupToDatabase() async {
    //People me

    // print(people[0].name);
    String prompt = randomizePrompt();

    await refGroup.set({
      'id': id,
      'name': name,
      'people': people,
      'pictureLimit': pictureLimit,
      'groupStarted': false,
      "textPrompt": prompt,
    });

    //database event listener - listen to people added or removed
    startListening();
  }

  void startListening() {
    refPeople.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      (data != null) ? eventUpdatePeopleList(data) : {};
    });

    refgroupStarted.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print("$id was started");
      (data != null) ? updateGroupStatus(data) : {};
    });
    refPictureTaker.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updatePictureTaker(data);
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

  void updateGroupStatus(groupStatus) {
    if (groupStatus != null) {
      groupStarted = groupStatus;
    }
    notifyListeners();
  }

  void startGroup(groupStatus) async {
    groupStarted = groupStatus;
    await refgroupStarted.set(groupStarted);
    await refGroup.update({"pictureTakerIndex": 0});

    notifyListeners();
  }

  void deleteGroup() async {
    DatabaseReference refUsers =
        FirebaseDatabase.instance.ref().child('people');

    //remove group string from each person in database
    for (String p in people) {
      DataSnapshot pGroup = await refUsers.child('$p/groups').get();
      if (pGroup.value != null) {
        List<String> pGroupValue = List<String>.from(pGroup.value as List);
        //Map dataMap = Map<String, dynamic>.from(pGroupValue as Map);
        List<String> currentGroups = pGroupValue;
        //dataMap['groups'].forEach((v) => currentGroups.add(v));

        currentGroups.contains(id) ? currentGroups.remove(id) : {};

        await refUsers.child('$p/groups').set(currentGroups);
      }
      //remove the group
      refGroup.remove();
    }
  }

  void incrementPti() async {
    pictureTakerIndex += 1;
    await refGroup.update({"pictureTakerIndex": pictureTakerIndex});

    notifyListeners();
  }

  bool myTurn(Person me) {
    int n = people.length;
    int currentPictureTaker = pictureTakerIndex % n;

    if (people[currentPictureTaker] == me.id) {
      return true;
    } else {
      return false;
    }
  }

  void updatePictureTaker(data) {
    if (data != null) {
      int index = data as int;
      pictureTakerIndex = index;
      if (pictureTakerIndex >= pictureLimit) {
        isFinished = true;
      }
      notifyListeners();
    }
  }

  Future<String> getNameFromId(Id) async {
    DatabaseReference refName =
        FirebaseDatabase.instance.ref().child('people/$Id/name');
    DataSnapshot snapshot = await refName.get();
    String userName = (snapshot.value as String);
    return (userName != null) ? userName : "Unable to fetch name";
  }

  Future<String> getTextPrompt() async {
    DataSnapshot snapshot = await refPrompt.get();
    String prompt = (snapshot.value as String);
    return prompt;
  }

  String randomizePrompt() {
    List<String> possiblePrompts = [
      "SOMETHING ENRAGING",
      "IMPOSSIBLE ODDS",
      "FROM ABOVE",
      "REFLECTIONS",
      "SEEK THE LIGHT",
      "ONE OF YOU",
      "STOLEN MOMENT"
    ];
    Random rnd = Random();
    String prompt = possiblePrompts[rnd.nextInt(possiblePrompts.length)];
    return prompt;
  }
}
