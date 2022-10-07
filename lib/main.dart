import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/PromptPage.dart';
import 'Screens/CameraPage.dart';
import 'Screens/ResultPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase/firebaseCommunication.dart';
import 'package:firebase_database/firebase_database.dart';

import 'dart:async';
import 'dart:io';

import 'firebase_options.dart';

late List<CameraDescription> cameras;
late FirebaseCommunication fb;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  fb = FirebaseCommunication();
  fb.initFirebase();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      initialRoute: "/",
      routes: {
        '/': (context) => HomeScreen(fb:fb),
        '/PromptPage': (context) => PromptPage(url: fb.getURlToTestImage(),),
        '/CameraPage': (context) => const CameraPage(),
        '/Result': (context) => const ResultPage(),
      },
    );
  }
}
