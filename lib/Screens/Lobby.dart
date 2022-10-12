import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mytakeapp/Providers/group_provider.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';
import '../main.dart';
import '../models/modelGroup.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

class Lobby extends StatelessWidget {
  Lobby({super.key});
  final groupNameController = TextEditingController();
  String groupId = '';

  @override
  Widget build(BuildContext context) {
    groupId = Provider.of<GroupProvider>(context, listen: false).groupId;
    Group group = Provider.of<GroupProvider>(context).group;
    if (group.groupStarted) {
      print("started group");
    }

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
                  child: Text(groupId, style: defaultText),
                ),
                const SizedBox(
                  height: 32,
                ),
                ChangeNotifierProvider(
                    create: (context) => group,
                    child: LobbyParticipantListener()),
                const SizedBox(
                  height: 64,
                ),
                InkWell(
                  onTap: () {
                    group.startGroup(true);
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text('Start', style: defaultText),
                          Spacer(),
                          Icon(CarbonIcons.arrow_right),
                        ],
                      ),
                    ),
                    decoration: buttonStyling,
                    width: 220,
                    height: 60,
                  ),
                ),
              ],
            ),
          ],
        ),
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
    Group group = Provider.of<GroupProvider>(context, listen: false).group;

    Future<String> getName(String id) async {
      DatabaseReference refPersonName =
          FirebaseDatabase.instance.ref().child('people/$id/name');
      DataSnapshot name = await refPersonName.get();
      return name.value.toString();
    }

    return Container(
      height: 200,
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: group.people.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: FutureBuilder(
                  future: getName(group.people[index]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                          child: Text('${snapshot.data}', style: defaultText));
                    } else {
                      return Container(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            );
          }),
    );
  }
}
