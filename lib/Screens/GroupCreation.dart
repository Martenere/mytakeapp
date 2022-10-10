import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import '../model.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

class GroupCreation extends StatelessWidget {
  GroupCreation({super.key});
  final groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        hintText: 'Kba..',
                        label: Text('GROUP NAME'),
                        border: OutlineInputBorder())),
              ),
              const SizedBox(
                height: 32,
              ),
              InkWell(
                onTap: () {
                  Group(id: 1, name: groupNameController.text, pictureLimit: 3);

                  print(groupNameController.text);
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
