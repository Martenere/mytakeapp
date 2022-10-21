import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:mytakeapp/Providers/group_provider.dart';
import 'package:mytakeapp/firebase/firebaseCommunication.dart';
import 'package:mytakeapp/loadAllGroups.dart';
import 'package:mytakeapp/main.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mytakeapp/models/modelPerson.dart';
import 'package:provider/provider.dart';

import '../models/modelGroup.dart';
import 'package:mytakeapp/id_retriever.dart';

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

class tocamerapageButton extends StatefulWidget {
  const tocamerapageButton({super.key});

  @override
  State<tocamerapageButton> createState() => _tocamerapageButtonState();
}

class _tocamerapageButtonState extends State<tocamerapageButton> {
  SvgPicture? tocamerapageImg;
  final tocamerapageUp = SvgPicture.asset('assets/img/tocamerapage.svg');
  final tocamerapageDown =
      SvgPicture.asset('assets/img/tocamerapage_ontapdown.svg');

  @override
  void initState() {
    super.initState();
    tocamerapageImg = tocamerapageUp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: tocamerapageImg,
      onTapDown: (details) {
        setState(() {
          tocamerapageImg = tocamerapageDown;
        });
      },
      onTapUp: (details) {
        setState(() {
          tocamerapageImg = tocamerapageUp;
        });
        Navigator.pushNamed(context, '/CameraPage');
      },
      onTapCancel: () {
        setState(() {
          tocamerapageImg = tocamerapageUp;
        });
      },
    );
  }
}

class playButton extends StatefulWidget {
  playButton({super.key, required this.group});
  Group group;

  @override
  State<playButton> createState() => _playButtonState();
}

class _playButtonState extends State<playButton> {
  SvgPicture? playImg;
  final playUp = SvgPicture.asset('assets/img/play.svg');
  final playDown = SvgPicture.asset('assets/img/play_ontapdown.svg');

  @override
  void initState() {
    super.initState();
    playImg = playUp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: playImg,
      onTapDown: (details) {
        setState(() {
          playImg = playDown;
        });
      },
      onTapUp: (details) {
        setState(() {
          playImg = playUp;
        });
        Provider.of<GroupProvider>(context, listen: false)
            .setGroup(widget.group);
        Navigator.pushNamed(context, '/PromptPage');
      },
      onTapCancel: () {
        setState(() {
          playImg = playUp;
        });
      },
    );
  }
}

class seetakesButton extends StatefulWidget {
  seetakesButton({super.key, required this.group});
  Group group;

  @override
  State<seetakesButton> createState() => _seetakesButtonState();
}

class _seetakesButtonState extends State<seetakesButton> {
  SvgPicture? seetakesImg;
  final seetakesUp = SvgPicture.asset('assets/img/seetakes.svg');
  final seetakesDown = SvgPicture.asset('assets/img/seetakes_ontapdown.svg');

  @override
  void initState() {
    super.initState();
    seetakesImg = seetakesUp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: seetakesImg,
      onTapDown: (details) {
        setState(() {
          seetakesImg = seetakesDown;
        });
      },
      onTapUp: (details) {
        setState(() {
          seetakesImg = seetakesUp;
        });
        Provider.of<GroupProvider>(context, listen: false)
            .setGroup(widget.group);
        Navigator.pushNamed(context, '/Result');
      },
      onTapCancel: () {
        setState(() {
          seetakesImg = seetakesUp;
        });
      },
    );
  }
}

class creategroupButton extends StatefulWidget {
  creategroupButton({super.key, required this.controller});
  TextEditingController controller;

  @override
  State<creategroupButton> createState() => _creategroupButtonState();
}

class _creategroupButtonState extends State<creategroupButton> {
  SvgPicture? creategroupImg;
  final creategroupUp = SvgPicture.asset('assets/img/creategroup.svg');
  final creategroupDown =
      SvgPicture.asset('assets/img/creategroup_ontapdown.svg');

  @override
  void initState() {
    super.initState();
    creategroupImg = creategroupUp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: creategroupImg,
      onTapDown: (details) {
        setState(() {
          creategroupImg = creategroupDown;
        });
      },
      onTapUp: (details) async {
        setState(() {
          creategroupImg = creategroupUp;
        });
        {
          var id = generateRandomString(2);
          var group = Group(
              groupStarted: false,
              id: id,
              name: widget.controller.text,
              people: [me.id], //Should add yourself to group aka (Person me)
              pictureLimit: 3,
              pictureTakerIndex: 0);

          await group.addGroupToDatabase();
          Provider.of<GroupProvider>(context, listen: false)
              .setGroupId(group.id);
          Provider.of<GroupProvider>(context, listen: false).setGroup(group);
          Navigator.pushReplacementNamed(context, '/Lobby');
        }
      },
      onTapCancel: () {
        setState(() {
          creategroupImg = creategroupUp;
        });
      },
    );
  }
}

class joingroupButton extends StatefulWidget {
  joingroupButton({super.key, required this.controller});
  TextEditingController controller;

  @override
  State<joingroupButton> createState() => _joingroupButtonState();
}

class _joingroupButtonState extends State<joingroupButton> {
  SvgPicture? joingroupImg;
  final joingroupUp = SvgPicture.asset('assets/img/joingroup.svg');
  final joingroupDown = SvgPicture.asset('assets/img/joingroup_ontapdown.svg');

  @override
  void initState() {
    super.initState();
    joingroupImg = joingroupUp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: joingroupImg,
      onTapDown: (details) {
        setState(() {
          joingroupImg = joingroupDown;
        });
      },
      onTapUp: (details) async {
        setState(() {
          joingroupImg = joingroupUp;
        });
        {
          Group? group = await loadGroupFromFirebase(widget.controller.text);

          if (group != null) {
            group.addPerson(me);
            Provider.of<GroupProvider>(context, listen: false).setGroup(group);
            Navigator.pushNamed(context, '/Lobby');
          }
        }
      },
      onTapCancel: () {
        setState(() {
          joingroupImg = joingroupUp;
        });
      },
    );
  }
}
