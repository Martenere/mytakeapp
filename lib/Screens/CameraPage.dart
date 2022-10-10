import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:carbon_icons/carbon_icons.dart';
import 'dart:math';
import 'package:image/image.dart' as IMG;

import 'package:mytakeapp/main.dart';
import 'HomeScreen.dart';
import 'package:mytakeapp/firebase/firebaseCommunication.dart';

// https://docs.flutter.dev/cookbook/plugins/picture-using-camera

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

  @override
  void initState() {
    super.initState();
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
    var buttonDepending = buttonStyling;

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
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
        ),
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
                    // child: Transform.scale(
                    //   scale: 1 / 1,
                    //   child: AspectRatio(
                    //     aspectRatio: controller.value.aspectRatio,
                    //     child: CameraPreview(controller),
                    //   ),
                    // ),
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
                    Container(
                      width: 80,
                      height: 80,
                      child: IconButton(
                        icon: Icon(CarbonIcons.camera),
                        iconSize: 45,
                        onPressed: () async {
                          try {
                            await _initializeControllerFuture;
                            final capturedImage =
                                await controller.takePicture();

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
                          }); //reinitializes the controller, turns off flashlight/lamp yeee
                        },
                      ),
                      decoration: buttonStyling,
                    ),
                    SizedBox(
                      width: 30,
                    ),

                    // AnimatedContainer(
                    //   duration: Duration(microseconds: 2),
                    //   width: 60,
                    //   height: 60,
                    //   decoration: buttonDepending,
                    //   child: Material(
                    //     child: InkWell(
                    //       child: Icon(CarbonIcons.flash),
                    //       onTap: () {
                    //         setState(() {
                    //           buttonDepending = buttonStylingDown;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),

                    Container(
                      width: 60,
                      height: 60,
                      child: IconButton(
                          icon: flashMode == FlashMode.off
                              ? Icon(CarbonIcons.flash_off)
                              : Icon(CarbonIcons.flash),
                          iconSize: 30,
                          onPressed: () {
                            setState(() {
                              if (flashMode == FlashMode.off) {
                                controller.setFlashMode(FlashMode.always);
                                flashMode = FlashMode.always;
                              } else {
                                controller.setFlashMode(FlashMode.off);
                                flashMode = FlashMode.off;
                              }
                            });
                          }),
                      decoration: buttonStyling,
                    ),

                    GestureDetector(
                        child: Container(
                          decoration: buttonDepending,
                          width: 60,
                          height: 60,
                          child: flashMode == FlashMode.off
                              ? Icon(CarbonIcons.flash_off)
                              : Icon(CarbonIcons.flash),
                        ),
                        onTap: (() {
                          setState(() {
                            buttonDepending = buttonStylingDown;
                          });
                        }))
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
    var backButtonResponsive = backButtonStyling;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 2),
                width: 45,
                height: 45,
                decoration: backButtonResponsive,
                child: IconButton(
                  padding: EdgeInsets.all(2),
                  icon: Icon(CarbonIcons.arrow_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
          ),
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
              Container(
                width: 80,
                height: 80,
                child: IconButton(
                    icon: Icon(CarbonIcons.checkmark),
                    iconSize: 40,
                    onPressed: () {
                      fb.uploadFile(File(imagePath));
                    }),
                decoration: buttonStyling,
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                width: 60,
                height: 60,
                child: IconButton(
                    icon: Icon(CarbonIcons.trash_can),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                decoration: buttonStyling,
              ),
            ],
          )
        ]));
  }
}

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
