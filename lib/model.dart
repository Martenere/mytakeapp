import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mytakeapp/firebase/firebaseDatabase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mytakeapp/id_retriever.dart';

class Person {
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
      groups = (data.child('groups').value as List<String>);
      dataLoaded = true;
    } else {}
  }

  addGroup(String groupId) {
    groups.add(groupId);
    refMe.update({'groups': groups});
  }

  removeGroup(String groupId) {
    groups.remove(groupId);
    refMe.update({'groups': groups});
  }
}

Future<Group> loadGroupFromFirebase(String id) async {
  DatabaseReference refGroup = await FirebaseDatabase.instance.ref("group/$id");
  DataSnapshot data = await refGroup.get();

  var name = (data.child('name') as String);
  var people = (data.child('people').value as List<Person>);
  var pictureLimit = (data.child('pictureLimit') as int);

  Group group =
      Group(id: id, name: name, people: people, pictureLimit: pictureLimit);

  return group;
}

class Group {
  late String id;
  String name;
  List<Person> people;

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
    await refGroup.set(
        {'id': id, 'name': name, people: people, pictureLimit: pictureLimit});

    //database event listener - listen to people added or removed

    refPeople.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      eventUpdatePeopleList(data);
      print("$data was recived from listener");
    });
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
