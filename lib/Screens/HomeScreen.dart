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
  final TextStyle defaultText = TextStyle(fontFamily: "PTMono");
  GroupPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Center(
                child: Text(
              "Kba KIllarna",
              style: defaultText,
            ))
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
    );
  }
}
