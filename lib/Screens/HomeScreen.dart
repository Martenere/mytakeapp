import 'package:flutter/material.dart';
import 'package:mytakeapp/firebase/firebaseCommunication.dart';

final BoxDecoration boxstyling = BoxDecoration(border: Border.all(width: 4));
final BoxDecoration boxstylingThick =
    BoxDecoration(border: Border.all(width: 8));
final BoxDecoration buttonStyling = BoxDecoration(
    border: Border.all(width: 4),
    color: Colors.white,
    boxShadow: [
      BoxShadow(offset: Offset(-4, 4), blurRadius: 0, color: Colors.black)
    ]);
final BoxDecoration backButtonStyling = BoxDecoration(
    border: Border.all(width: 2),
    color: Colors.white,
    boxShadow: [
      BoxShadow(offset: Offset(-2, 2), blurRadius: 0, color: Colors.black)
    ]);
final BoxDecoration boxFullstyling = BoxDecoration(
    color: const Color(0xFFC36AC7E),
    border: Border.symmetric(horizontal: BorderSide(width: 3)));
final Color primaryColor = Color.fromARGB(255, 54, 172, 126);
final TextStyle defaultText = TextStyle(
    fontFamily: "PTMono-reg",
    fontSize: 36,
    color: Colors.black,
    letterSpacing: 8);
final TextStyle timeText = TextStyle(
    fontFamily: "PTMono-reg",
    fontSize: 16,
    color: Colors.black,
    letterSpacing: 8);

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.fb});
  FirebaseCommunication fb;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MYTAKE.",
          style: defaultText,
        ),
        titleTextStyle: defaultText,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 110,
      ),
      body: Column(children: [
        GroupPane(groupName: "KBA killar."),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/PromptPage');
            },
            child: Text('Prompt page')),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/CameraPage');
            },
            child: Text('Camera Page')),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Result');
            },
            child: Text('Result Page')),
        ElevatedButton(onPressed: () {}, child: Text('add image to server'))
      ]),
    );
  }
}

class GroupPane extends StatelessWidget {
  String groupName;
  GroupPane({super.key, required this.groupName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxFullstyling,
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                groupName,
                style: defaultText,
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileSquarePic(size: 77),
              const SizedBox(width: 24),
              ProfileSquarePic(
                size: 200,
              ),
              const SizedBox(width: 24),
              ProfileSquarePic(size: 100),
            ],
          ),
          const SizedBox(
            height: 48,
          ),
          Row(children: [HardButton()]),
        ],
      ),
    );
  }
}

class ProfileSquarePic extends StatelessWidget {
  const ProfileSquarePic({
    required this.size,
    super.key,
  });
  final int size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.0,
      height: 48.0,
      decoration: boxstyling,
      child: Image.network('https://picsum.photos/$size'),
    );
  }
}

class HardButton extends StatelessWidget {
  const HardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 48.0,
        height: 48.0,
        decoration: buttonStyling,
      ),
    );
  }
}
