import 'package:flutter/material.dart';

class Person {

String id;
String name;
Color color;

Person({required this.id,required this.name,required this.color});

}

class Group {

  int id;
  String name;
  List<Person> people;
  bool isFinished;
  int pictureLimit;

  Group({required this.id, required this.name,required this.people ,this.isFinished = false, required this.pictureLimit});
  
}
