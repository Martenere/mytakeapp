import 'package:flutter/material.dart';
import 'package:mytakeapp/firebase/firebaseDatabase.dart';
import 'package:firebase_database/firebase_database.dart';

class Person {
  String id;
  String name;
  Color color;
  List<String> groups = [];

  Person({required this.id, required this.name, required this.color}) {}

  addGroup(String groupId) {
    groups.add(groupId);
  }

  removeGroup(String groupId) {
    groups.remove(groupId);
  }
}

class Group {
  int id;
  String name;
  List<Person> people;

  bool isFinished;
  int pictureLimit;
  late FirebaseGroup _fbd;
  late var refPeople;

  Group(
      {required this.id,
      required this.name,
      required this.people,
      this.isFinished = false,
      required this.pictureLimit}) {
    _fbd = FirebaseGroup(id.toString());

    refPeople = FirebaseDatabase.instance.ref().child('group/$id/people');

    //database event listener - listen to people added or removed
    refPeople.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      eventUpdatePeopleList(data);
      print("$data was recived from listener");
    });
  }

  initGroupInDatabase() {
    _fbd.addGroupToDatabase(name);
  }

  void eventUpdatePeopleList(data) {
    people = []; //empty data in people list

    for (Person p in data) {
      // add people from recieved data
      people.add(p);
    }
    //notify listeners
  }
}
