import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/PromptPage.dart';
import 'Screens/CameraPage.dart';
import 'Screens/ResultPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:async';
import 'dart:io';

import 'firebase_options.dart';

late List<CameraDescription> cameras;

// final FirebaseAuth auth = FirebaseAuth.instance;
// final user = await auth.signInWithGoogle(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//  );

final storage = FirebaseStorage.instance;
final storageRef = FirebaseStorage.instance.ref();
final testRef = storageRef.child("test");
final spaceRef = storageRef.child("test/test_image.png");
final gsReference =
    storage.refFromURL("gs://mytake-a7a56.appspot.com/test/test_image.png");


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

String dataUrl = 'data:text/plain;base64,SGVsbG8sIFdvcmxkIQ==';

try {
  await testRef.putString(dataUrl, format: PutStringFormat.dataUrl);
} on FirebaseException catch (e) {
}

final imageUrl = await spaceRef.getDownloadURL();
print(imageUrl);

print(testRef);
print(spaceRef.name);
print(gsReference.name);




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
        '/': (context) => const HomeScreen(),
        '/PromptPage': (context) => const PromptPage(),
        '/CameraPage': (context) => const CameraPage(),
        '/Result': (context) => const ResultPage(),
      },
    );
  }
}
