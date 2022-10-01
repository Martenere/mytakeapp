import 'package:flutter/material.dart';


  final BoxDecoration boxstyling = BoxDecoration(border: Border.all(width: 4));
  final BoxDecoration buttonStyling = BoxDecoration(border: Border.all(width: 4), color: Colors.white, boxShadow: [BoxShadow(offset: Offset(-4,4), blurRadius: 0, color: Colors.black)]);
  final BoxDecoration boxFullstyling = BoxDecoration(color: const Color(0xFFC36AC7E), border: Border.symmetric(horizontal: BorderSide(width:3)));
  final TextStyle defaultText = TextStyle(fontFamily: "PTMono", fontWeight: FontWeight.w100,  fontSize: 36, color: Colors.black, letterSpacing: 8);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MYTAKE.", style: defaultText,),  titleTextStyle: defaultText, elevation: 0, backgroundColor: Colors.white, toolbarHeight: 110,),
      body: Column(children: [
        
        GroupPane(groupName: "KBA killar.")
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
          Row( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              ProfileSquarePic(size:77),
              const SizedBox(width: 24),ProfileSquarePic(size: 200,),
              const SizedBox(width: 24), ProfileSquarePic(size:100),
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
  const ProfileSquarePic({required this.size , super.key, });
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