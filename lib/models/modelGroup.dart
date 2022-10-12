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

  Group group =
      Group(id: id, name: name, people: people, pictureLimit: pictureLimit);

  return group;
}

class Group {
  late String id;
  String name;
  List<String> people;

  bool isFinished;
  int pictureLimit;
  late FirebaseGroup _fbd;
  late var refPeople;
  late var refGroup;

  Group(
      {required this.id,
      required this.name,
      required this.people,
      this.isFinished = false,
      this.pictureLimit = 3}) {
    refPeople = FirebaseDatabase.instance.ref().child('group/$id/people');
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
      'pictureLimit': pictureLimit
    });

    //database event listener - listen to people added or removed

    refPeople.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      eventUpdatePeopleList(data);
      print("$data was recived from listener");
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
      print(p);
    }
    //notify listeners
  }
}
