import 'package:flutter/material.dart';
import 'HomeScreen.dart';

import '../models/buttons.dart';

class JoinGroup extends StatelessWidget {
  JoinGroup({super.key});
  final GroupCodeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
            child: backButton()),
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
                    maxLength: 4,
                    decoration: InputDecoration(
                        hintText: 'A123',
                        label: Text('ENTER CODE'),
                        border: OutlineInputBorder())),
              ),
              const SizedBox(
                height: 32,
              ),
              joingroupButton(controller: GroupCodeController),
          
            ],
          ),
        ],
      ),
    );
  }
}
