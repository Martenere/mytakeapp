import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/PromptPage.dart';
import 'Screens/CameraPage.dart';
import 'Screens/ResultPage.dart';
<<<<<<< Updated upstream
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';


void main() {
  
=======
import 'dart:async';
import 'dart:io';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
>>>>>>> Stashed changes
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
        '/': (context) => const HomeScreen(),
        '/PromptPage': (context) => const PromptPage(),
        '/CameraPage': (context) => const CameraPage(),
        '/Result': (context) => const ResultPage(),
      },
    );
  }
}
