import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mytakeapp/Providers/group_provider.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/modelGroup.dart';
import 'HomeScreen.dart';
import '../models/buttons.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

class PromptPage extends StatelessWidget {
  PromptPage({super.key});
  late Future<String> url;
  late Future<String> prompt;

  @override
  Widget build(BuildContext context) {
    Group group = Provider.of<GroupProvider>(context, listen: false).group;
    int curPic = Provider.of<GroupProvider>(context, listen: false)
        .group
        .pictureTakerIndex;
    bool firstPic = (curPic == 0);
    if (!firstPic) {
      url = fb.getLatestGroupImageURL(
          Provider.of<GroupProvider>(context, listen: false).group);
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
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
            Positioned(
                child: Container(
              height: 350,
              width: 400,
              color: primaryColor,
            )),
            Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                FutureBuilder(
                    //Name of previous picture taker at top
                    future: group.previousPictureTaker,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!, style: defaultText);
                      } else {
                        return SizedBox();
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                      decoration: boxstylingThick,
                      child: firstPic
                          ? promptText(prompt: group.getTextPrompt())
                          : promptPicture(url: url)),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text('MYTAKE', style: defaultText),
                const SizedBox(
                  height: 12,
                ),
                tocamerapageButton(),
                SizedBox(
                  height: 32,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class promptPicture extends StatelessWidget {
  const promptPicture({
    Key? key,
    required this.url,
  }) : super(key: key);

  final Future<String> url;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: url,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return Container(
                height: size,
                width: size,
                child: Image.network(snapshot.data!, fit: BoxFit.fitWidth));
          } else {
            return SizedBox();
          }
        });
  }
}

class promptText extends StatelessWidget {
  const promptText({
    Key? key,
    required this.prompt,
  }) : super(key: key);

  final Future<String> prompt;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: prompt,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Container(
                color: Colors.white,
                width: 300,
                height: 300,
                child: Center(
                    child: Text(snapshot.data!.toUpperCase(),
                        style: defaultText)));
          } else {
            return SizedBox();
          }
        });
  }
}
