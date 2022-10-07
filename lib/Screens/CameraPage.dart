import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:carbon_icons/carbon_icons.dart';

import 'package:mytakeapp/main.dart';
import 'HomeScreen.dart';

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
                    child: Transform.scale(
                      scale: 1 / 1,
                      child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: CameraPreview(controller),
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
                    Container(
                      width: 80,
                      height: 80,
                      child: IconButton(
                        icon: Icon(CarbonIcons.camera),
                        onPressed: () async {
                          try {
                            await _initializeControllerFuture;
                            final image = await controller.takePicture();
                            if (!mounted) return;
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DisplayPictureScreen(
                                  imagePath: image.path,
                                ),
                              ),
                            );
                          } catch (e) {
                            print(e);
                          }
                        },
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
        appBar: AppBar(
          leading: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
            child: Container(
                width: 45,
                height: 45,
                decoration: backButtonStyling,
                child: IconButton(
                  padding: EdgeInsets.all(2),
                  icon: Icon(CarbonIcons.arrow_left),
                  onPressed: () {},
                )),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 110,
          foregroundColor: Colors.black,
        ),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
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
                    icon: Icon(CarbonIcons.checkmark), onPressed: () {}),
                decoration: buttonStyling,
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                width: 60,
                height: 60,
                child: Icon(
                  CarbonIcons.trash_can,
                  size: 30,
                ),
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


//child: CameraPreview(controller)