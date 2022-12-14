import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mytakeapp/Providers/group_provider.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';
import '../main.dart';
import '../models/modelGroup.dart';
import 'package:carbon_icons/carbon_icons.dart';
import '../models/buttons.dart';

class Lobby extends StatelessWidget {
  Lobby({super.key});
  final groupNameController = TextEditingController();
  String groupId = '';

  @override
  Widget build(BuildContext context) {
    Group group = Provider.of<GroupProvider>(context, listen: true).group;

    if (group.groupStarted) {
      print("Started group");
    }

    return ChangeNotifierProvider.value(
      value: group,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
            child: backButton(),
            // child: Icon(CarbonIcons.arrow_left)),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 110,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Text('SESSION CODE', style: defaultText),
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(group.id, style: defaultText),
                  ),
                  // const SizedBox(
                  //   height: 32,
                  // ),
                  Divider(
                    height: 20,
                    thickness: 3,
                    indent: 120,
                    endIndent: 120,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LobbyParticipantListener(),
                  const SizedBox(
                    height: 64,
                  ),
                  (group.people[0] == me.id)
                      ? StartSessionButton(group: group)
                      : SizedBox(
                          width: MediaQuery.of(context).size.width - 50,
                          child: Text(
                            'WAITING FOR INITIALIZATION...',
                            style: smNmameText,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StartSessionButton extends StatelessWidget {
  const StartSessionButton({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        group.startGroup(true);
        // ADD GROUP TO PERSON
        me.addGroup(group.id);
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text('START', style: defaultText),
              Spacer(),
              Icon(CarbonIcons.arrow_right),
            ],
          ),
        ),
        decoration: buttonStyling,
        width: 220,
        height: 60,
      ),
    );
  }
}

class LobbyParticipantListener extends StatelessWidget {
  const LobbyParticipantListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> getName(String id) async {
      DatabaseReference refPersonName =
          FirebaseDatabase.instance.ref().child('people/$id/name');
      DataSnapshot name = await refPersonName.get();
      return name.value.toString();
    }

    return Consumer<Group>(
        builder: ((context, group, child) => Container(
              height: 200,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: group.people.length,
                  itemBuilder: (BuildContext context, int index) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      print("post fram");
                      if (group.groupStarted) {
                        me.addGroup(group.id);
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName('/'));
                        //Navigator.of(context).pop();
                      }
                    });
                    return Container(
                      height: 50,
                      child: FutureBuilder(
                          future: getName(group.people[index]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Center(
                                  child: Text('${snapshot.data}',
                                      style: defaultText));
                            } else {
                              return Container(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    );
                  }),
            )));
  }
}
