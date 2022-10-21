import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

class backButton extends StatefulWidget {
  const backButton({super.key});

  @override
  State<backButton> createState() => _backButtonState();
}

class _backButtonState extends State<backButton> {
  SvgPicture? backImg;
  final backUp = SvgPicture.asset('assets/img/backbutton.svg');
  final backDown = SvgPicture.asset('assets/img/backbutton_ontapdown.svg');

  @override
  void initState() {
    super.initState();
    backImg = backUp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: backImg,
      onTapDown: (details) {
        setState(() {
          backImg = backDown;
        });
      },
      onTapUp: (details) {
        backImg = backUp;
        Navigator.pop(context);
      },
      onTapCancel: () {
        setState(() {
          backImg = backUp;
        });
      },
    );
  }
}
