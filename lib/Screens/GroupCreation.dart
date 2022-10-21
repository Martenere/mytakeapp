import 'package:flutter/material.dart';
import 'package:mytakeapp/Providers/group_provider.dart';
import 'package:mytakeapp/Screens/Lobby.dart';
import 'package:mytakeapp/id_retriever.dart';
import 'package:provider/provider.dart';
import '../models/modelPerson.dart';
import 'HomeScreen.dart';
import '../main.dart';
import '../models/modelGroup.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

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
          child: Container(
              decoration: backButtonStyling,
              child: BackButton(color: Colors.black)),
          // child: Icon(CarbonIcons.arrow_left)),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 110,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // Positioned(
          //     child: Container(
          //   height: 350,
          //   width: 400,
          //   color: primaryColor,
          // )),
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
              InkWell(
                onTap: () async {
                  var id = generateRandomString(2);
                  var group = Group(
                      groupStarted: false,
                      id: id,
                      name: groupNameController.text,
                      people: [
                        me.id
                      ], //Should add yourself to group aka (Person me)
                      pictureLimit: 3,
                      pictureTakerIndex: 0);

                  await group.addGroupToDatabase();
                  Provider.of<GroupProvider>(context, listen: false)
                      .setGroupId(group.id);
                  Provider.of<GroupProvider>(context, listen: false)
                      .setGroup(group);
                  Navigator.pushReplacementNamed(context, '/Lobby');
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text('Create', style: defaultText),
                        Spacer(),
                        Icon(CarbonIcons.arrow_right),
                      ],
                    ),
                  ),
                  decoration: buttonStyling,
                  width: 260,
                  height: 60,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
