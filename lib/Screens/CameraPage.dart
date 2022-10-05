import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mytakeapp/main.dart';
import 'package:carbon_icons/carbon_icons.dart';
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

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    _initializeControllerFuture = controller.initialize();
    // controller.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // }).catchError((Object e) {
    //   if (e is CameraException) {
    //     switch (e.code) {
    //       case 'CameraAccessDenied':
    //         print('User denied camera access.');
    //         break;
    //       default:
    //         print('Handle other errors.');
    //         break;
    //     }
    //   }
    // });
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
      return Container(
        child: Text('Hello'),
      );
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
      body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return Column(children: [
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
                    // ---- camera button -----
                    Container(
                      width: 80,
                      height: 80,
                      child: IconButton(
                        icon: Icon(CarbonIcons.camera),
                        onPressed: () async {
                          // Take the Picture in a try / catch block. If anything goes wrong,
                          // catch the error.
                          try {
                            // Ensure that the camera is initialized.
                            await _initializeControllerFuture;

                            // Attempt to take a picture and get the file `image`
                            // where it was saved.
                            final image = await controller.takePicture();

                            if (!mounted) return;

                            // If the picture was taken, display it on a new screen.
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DisplayPictureScreen(
                                  // Pass the automatically generated path to
                                  // the DisplayPictureScreen widget.
                                  imagePath: image.path,
                                ),
                              ),
                            );
                          } catch (e) {
                            // If an error occurs, log the error to the console.
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
                    ), //Control panel
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
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Text('u took a picture'),
    );
  }
}

//home: CameraPreview(controller),