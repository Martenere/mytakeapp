import 'package:flutter/material.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/PromptPage.dart';
import 'Screens/CameraPage.dart';
import 'Screens/ResultPage.dart';

void main() {
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
