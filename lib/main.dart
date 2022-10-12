import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mytakeapp/Providers/group_provider.dart';
import 'package:mytakeapp/firebase/firebaseDatabase.dart';
import 'package:provider/provider.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/Lobby.dart';
import 'Screens/PromptPage.dart';
import 'Screens/CameraPage.dart';
import 'Screens/ResultPage.dart';
import 'Screens/GroupCreation.dart';
import 'Screens/JoinGroup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase/firebaseCommunication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'id_retriever.dart';
import 'model.dart';

import 'dart:async';
import 'dart:io';

import 'firebase_options.dart';

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
  runApp(ChangeNotifierProvider(
      create: (_) => GroupProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      initialRoute: "/",
      routes: {
        '/': (context) => HomeScreen(fb: fb),
        '/PromptPage': (context) => PromptPage(
              url: fb.getURlToTestImage(),
            ),
        '/CameraPage': (context) => const CameraPage(),
        '/Result': (context) => const ResultPage(),
        '/GroupCreation': (context) => GroupCreation(),
        '/JoinGroup': (context) => JoinGroup(),
        '/Lobby': (context) => Lobby(),
      },
    );
  }
}
