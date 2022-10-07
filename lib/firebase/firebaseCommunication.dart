import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';

import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseCommunication {
  late final storage;
  late final storageRef;

  firebaseCommunication() {}

  void initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Initialized firebase");

    // Storage
    storage = FirebaseStorage.instance;
    storageRef = FirebaseStorage.instance.ref();
    // Database
    FirebaseDatabase database = FirebaseDatabase.instance;
  }

  void sendStringToStorage() async {
    final testRef = storageRef.child("test");
    String dataUrl = 'data:text/plain;base64,SGVsbG8sIFdvcmxkIQ==';

    try {
      await testRef.putString(dataUrl, format: PutStringFormat.dataUrl);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> getURlToTestImage() async {
    final spaceRef = storageRef.child("test/test_image.png");
    var imageURL = await spaceRef.getDownloadURL();
    return imageURL;
  }
// imageData, targetLocation
  uploadFile() async {
    var catPhotoUrl = Uri.parse(
        'https://i.picsum.photos/id/682/200/200.jpg?hmac=098XkPnTe9a41I6BtB9xV4t6L8c3ESkdowMLElFBR5A');

    final http.Response responseData = await http.get(catPhotoUrl);

    Uint8List uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/img').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String filePath = '${appDocDir.absolute}/file-to-upload.png';
//     File file = File(filePath);

      String groupName = 'test';
      var storageRefList = await (storageRef.child(groupName).listAll());
      print(storageRefList.items[0].fullPath);
      for (var item in storageRefList.items) {
        print(item.fullPath);
      }

    try {
      await storageRef.child("$groupName/funnycat_image1.jpg").putFile(file);
    } on Error catch (e) {}
  }
}
