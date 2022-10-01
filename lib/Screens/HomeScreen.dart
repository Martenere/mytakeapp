import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MYTAKE.")),
      body: Column(children: [
        const SizedBox(
          height: 16,
        ),
        GroupPane()
      ]),
    );
  }
}

class GroupPane extends StatelessWidget {
  final BoxDecoration boxstyling = BoxDecoration(border: Border.all(width: 4));
  final BoxDecoration boxFullstyling =
      BoxDecoration(border: Border.symmetric(horizontal: BorderSide(width: 4)));
  final TextStyle defaultText = TextStyle(fontFamily: "PTMono", fontSize: 36);
  GroupPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxFullstyling,
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "KBA Killarna",
                style: defaultText,
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 24,
              ),
              Container(
                width: 48.0,
                height: 48.0,
                decoration: boxstyling,
              )
            ],
          ),
          Row(),
        ],
      ),
    );
  }
}
