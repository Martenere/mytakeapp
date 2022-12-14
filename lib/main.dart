import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mytakeapp/Providers/group_provider.dart';
import 'package:provider/provider.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/Lobby.dart';
import 'Screens/PromptPage.dart';
import 'Screens/CameraPage.dart';
import 'Screens/ResultPage.dart';
import 'Screens/GroupCreation.dart';
import 'Screens/JoinGroup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebaseCommunication.dart';
import 'id_retriever.dart';

import 'dart:async';

import 'firebase_options.dart';
import 'models/modelPerson.dart';

late List<CameraDescription> cameras;
late FirebaseCommunication fb;
late Person me;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Initialized firebase");

  var id = await getId();
  me = Person(id: id);
  await me.loadDataFromFirebase();

  print("device id: $id");
  fb = FirebaseCommunication();
  fb.initFirebase();
  cameras = await availableCameras();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<GroupProvider>(create: (_) => GroupProvider()),
    ChangeNotifierProvider<Person>(create: (_) => me)
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      initialRoute: "/",
      routes: {
        '/': (context) => HomeScreen(fb: fb),
        '/PromptPage': (context) => PromptPage(),
        '/CameraPage': (context) => const CameraPage(),
        '/Result': (context) => const ResultPage(),
        '/GroupCreation': (context) => GroupCreation(),
        '/JoinGroup': (context) => JoinGroup(),
        '/Lobby': (context) => Lobby(),
      },
    );
  }
}
