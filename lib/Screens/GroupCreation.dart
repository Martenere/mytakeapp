import 'package:flutter/material.dart';
import '../models/modelPerson.dart';
import 'HomeScreen.dart';
import '../models/buttons.dart';

class GroupCreation extends StatelessWidget {
  GroupCreation({super.key});
  final groupNameController = TextEditingController();
  Person jacob = Person(
    id: '1',
    name: 'jacob',
  );
  late List<Person> dummyPeople = [jacob];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
          child: backButton(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 110,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              Text('NEW SESSION', style: defaultText),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: groupNameController,
                    style: defaultText,
                    decoration: InputDecoration(
                        hintText: 'GROUP NAME',
                        label: Text('GROUP NAME'),
                        border: OutlineInputBorder())),
              ),
              const SizedBox(
                height: 32,
              ),
              creategroupButton(
                controller: groupNameController,
              ),

            
            ],
          ),
        ],
      ),
    );
  }
}
