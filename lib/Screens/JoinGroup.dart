import 'package:flutter/material.dart';
import 'package:mytakeapp/Providers/group_provider.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';
import '../main.dart';
import '../models/modelGroup.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

class JoinGroup extends StatelessWidget {
  JoinGroup({super.key});
  final GroupCodeController = TextEditingController();

  // Person jacob = Person(
  //   id: '1',
  //   name: 'jacob',
  // );
  // late List<Person> dummyPeople = [jacob];

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
              Text('JOIN SESSION', style: defaultText),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: GroupCodeController,
                    style: defaultText,
                    decoration: InputDecoration(
                        hintText: 'Kba..',
                        label: Text('ENTER CODE'),
                        border: OutlineInputBorder())),
              ),
              const SizedBox(
                height: 32,
              ),
              InkWell(
                onTap: () async {
                  Group? group =
                      await loadGroupFromFirebase(GroupCodeController.text);
                  
                  if (group!=null) {
                    group.addPerson(me);
                    Provider.of<GroupProvider>(context, listen: false)
                        .setGroup(group);
                    Navigator.pushNamed(context, '/Lobby');
                  }
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text('Join', style: defaultText),
                        Spacer(),
                        Icon(CarbonIcons.arrow_right),
                      ],
                    ),
                  ),
                  decoration: buttonStyling,
                  width: 220,
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
