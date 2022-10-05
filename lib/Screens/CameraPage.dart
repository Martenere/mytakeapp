import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mytakeapp/main.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'HomeScreen.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({
    super.key,
  });

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;

    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
          child: Container(
              width: 45,
              height: 45,
              decoration: backButtonStyling,
              child: IconButton(
                padding: EdgeInsets.all(2),
                icon: Icon(CarbonIcons.arrow_left),
                onPressed: () {},
              )),
          // child: Icon(CarbonIcons.arrow_left)),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 110,
        foregroundColor: Colors.black,
      ),
      body: Column(children: [
        SizedBox(width: size, height: 30),
        Container(
          child: CameraPreview(controller),
          width: size,
          height: size,
          decoration: boxstylingThick,
        ),
        SizedBox(
          width: size,
          height: 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              child: Icon(
                CarbonIcons.camera,
                size: 50,
              ),
              decoration: buttonStyling,
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              width: 60,
              height: 60,
              child: Icon(
                CarbonIcons.flash_off,
                size: 30,
              ),
              decoration: buttonStyling,
            ), //Control panel
          ],
        )
      ]),
    );
  }
}


//home: CameraPreview(controller),