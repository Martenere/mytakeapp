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

class joinButton extends StatefulWidget {
  const joinButton({super.key});

  @override
  State<joinButton> createState() => _joinButtonState();
}

class _joinButtonState extends State<joinButton> {
  SvgPicture? joinImg;
  final joinUp = SvgPicture.asset('assets/img/join.svg');
  final joinDown = SvgPicture.asset('assets/img/join_ontapdown.svg');

  @override
  void initState() {
    super.initState();
    joinImg = joinUp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: joinImg,
      onTapDown: (details) {
        setState(() {
          joinImg = joinDown;
        });
      },
      onTapUp: (details) {
        setState(() {
          joinImg = joinUp;
        });
        Navigator.pushNamed(context, '/JoinGroup');
      },
      onTapCancel: () {
        setState(() {
          joinImg = joinUp;
        });
      },
    );
  }
}

class createButton extends StatefulWidget {
  const createButton({super.key});

  @override
  State<createButton> createState() => _createButtonState();
}

class _createButtonState extends State<createButton> {
  SvgPicture? createImg;
  final createUp = SvgPicture.asset('assets/img/create.svg');
  final createDown = SvgPicture.asset('assets/img/create_ontapdown.svg');

  @override
  void initState() {
    super.initState();
    createImg = createUp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: createImg,
      onTapDown: (details) {
        setState(() {
          createImg = createDown;
        });
      },
      onTapUp: (details) {
        setState(() {
          createImg = createUp;
        });
        Navigator.pushNamed(context, '/GroupCreation');
      },
      onTapCancel: () {
        setState(() {
          createImg = createUp;
        });
      },
    );
  }
}
