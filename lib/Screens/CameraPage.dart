import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mytakeapp/main.dart';
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
  late Future<void> _initializeControllerFuture;
  XFile? image;
  FlashMode flashMode = FlashMode.off;
  SvgPicture? cameraImg;
  SvgPicture? flashImg;

  var cameraUp = SvgPicture.asset('assets/img/camera.svg');
  var cameraDown = SvgPicture.asset('assets/img/camera_ontapdown.svg');
  var flashOnUp = SvgPicture.asset('assets/img/flashon.svg');
  var flashOnDown = SvgPicture.asset('assets/img/flashon_ontapdown.svg');
  var flashOffUp = SvgPicture.asset('assets/img/flashoff.svg');
  var flashOffDown = SvgPicture.asset('assets/img/flashoff_ontapdown.svg');

  @override
  void initState() {
    super.initState();
    cameraImg = cameraUp;
    flashImg = flashOffUp;
    controller = CameraController(
      cameras[0],
      ResolutionPreset.max,
      enableAudio: false,
    );
    _initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;

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
      body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return Column(children: [
                SizedBox(width: size, height: 30),
                Container(
                  width: size,
                  height: size,
                  decoration: boxstylingThick,
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container(
                          width: size,
                          height: size * 1.6, //hardcoded
                          child: CameraPreview(controller),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size,
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ---- camera button -----
                    GestureDetector(
                      child: cameraImg,
                      onTapDown: ((tap) {
                        setState(() {
                          cameraImg = cameraDown;
                        });
                      }),
                      onTapUp: (tap) {
                        setState(() {
                          cameraImg = cameraUp;
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          cameraImg = cameraUp;
                        });
                      },
                      onTap: () async {
                        try {
                          await _initializeControllerFuture;
                          final capturedImage = await controller.takePicture();

                          if (!mounted) return;
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DisplayPictureScreen(
                                imagePath: capturedImage.path,
                              ),
                            ),
                          );
                        } catch (e) {
                          print(e);
                        }
                        Future.delayed(const Duration(milliseconds: 2), () {
                          controller.initialize();
                        });
                        //reinitializes the controller, turns off flashlight/lamp yeee, might become a problem
                      },
                    ),

                    SizedBox(
                      width: 30,
                    ),

                    GestureDetector(
                      child: flashImg,
                      onTapDown: (tap) {
                        setState(() {
                          if (flashImg == flashOffUp) {
                            flashImg = flashOffDown;
                          } else if (flashImg == flashOnUp) {
                            flashImg = flashOnDown;
                          }
                        });
                      },
                      onTapUp: (tap) {
                        setState(() {
                          if (flashImg == flashOffDown) {
                            flashMode = FlashMode.always;
                            controller.setFlashMode(FlashMode.always);
                            flashImg = flashOnUp;
                          } else if (flashImg == flashOnDown) {
                            flashMode = FlashMode.off;
                            controller.setFlashMode(FlashMode.off);
                            flashImg = flashOffUp;
                          }
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          if (flashImg == flashOffDown) {
                            flashImg = flashOffUp;
                          } else if (flashImg == flashOnDown) {
                            flashImg = flashOnUp;
                          }
                        });
                      },
                    ),
                  ],
                )
              ]);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;

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
        body: Column(children: [
          SizedBox(width: size, height: 30),
          Container(
            child: Image.file(
              File(imagePath),
              fit: BoxFit.fitWidth,
            ),
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
              checkButton(imagePath: imagePath),
              SizedBox(
                width: 30,
              ),
              trashbutton(),
            ],
          )
        ]));
  }
}

//-----buttons-----

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

class trashbutton extends StatefulWidget {
  const trashbutton({super.key});

  @override
  State<trashbutton> createState() => _trashbuttonState();
}

class _trashbuttonState extends State<trashbutton> {
  SvgPicture? trashImg;
  final trashUp = SvgPicture.asset('assets/img/trash.svg');
  final trashDown = SvgPicture.asset('assets/img/trash_ontapdown.svg');

  @override
  void initState() {
    super.initState();
    trashImg = trashUp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: trashImg,
      onTapDown: (details) {
        setState(() {
          trashImg = trashDown;
        });
      },
      onTapUp: (details) {
        setState(() {
          trashImg = trashUp;
          Navigator.pop(context);
        });
      },
      onTapCancel: () {
        setState(() {
          trashImg = trashUp;
        });
      },
    );
  }
}

class checkButton extends StatefulWidget {
  final String imagePath;
  checkButton({super.key, required this.imagePath});

  @override
  State<checkButton> createState() => _checkButtonState();
}

class _checkButtonState extends State<checkButton> {
  SvgPicture? checkImg;
  final checkUp = SvgPicture.asset('assets/img/check.svg');
  final checkDown = SvgPicture.asset('assets/img/check_ontapdown.svg');

  @override
  void initState() {
    super.initState();
    checkImg = checkUp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: checkImg,
      onTapDown: (details) {
        setState(() {
          checkImg = checkDown;
        });
      },
      onTapUp: (details) {
        setState(() {
          checkImg = checkUp;
        });
        fb.uploadFile(File(widget.imagePath));
      },
      onTapCancel: () {
        setState(() {
          checkImg = checkUp;
        });
      },
    );
  }
}



//------Garbage-----

// class ImageProcessor {
//   static Future cropSquare(
//       String srcFilePath, String destFilePath, bool flip) async {
//     var bytes = await File(srcFilePath).readAsBytes();
//     IMG.Image? src = IMG.decodeImage(bytes);

//     var cropSize = min(src.width, src.height);
//     int offsetX = (src.width - min(src.width, src.height)) ~/ 2;
//     int offsetY = (src.height - min(src.width, src.height)) ~/ 2;

//     IMG.Image destImage =
//         IMG.copyCrop(src, offsetX, offsetY, cropSize, cropSize);

//     if (flip) {
//       destImage = IMG.flipVertical(destImage);
//     }

//     var jpg = IMG.encodeJpg(destImage);
//     await File(destFilePath).writeAsBytes(jpg);
//   }
// }
