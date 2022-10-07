import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';




class FirebaseCommunication{
      late final storage;
      late final storageRef;


      firebaseCommunication(){
      }

    void initFirebase() async {
      await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
      );
      print("Initialized firebase");
      storage = FirebaseStorage.instance;
      storageRef = FirebaseStorage.instance.ref();
    }

    void sendStringToStorage() async {
      final testRef = storageRef.child("test");
      String dataUrl = 'data:text/plain;base64,SGVsbG8sIFdvcmxkIQ==';

      try {
        await testRef.putString(dataUrl, format: PutStringFormat.dataUrl);
      } on FirebaseException catch (e) { print(e);}

    }

    Future<String> getURlToTestImage() async {
      final spaceRef = storageRef.child("test/test_image.png");
      var imageURL = await spaceRef.getDownloadURL();
      return imageURL;

    }
    uploadFile(){
      
    }
}