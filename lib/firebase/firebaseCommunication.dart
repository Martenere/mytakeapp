import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/modelGroup.dart';
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
  uploadFile(File image, Group group) async {
    File file = await image;
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String filePath = '${appDocDir.absolute}/file-to-upload.png';
//     File file = File(filePath);

    String groupId = group.id;
    var storageRefList = await (storageRef.child(groupId).listAll());
    print(storageRefList.items[0].fullPath);
    for (var item in storageRefList.items) {
      print(item.fullPath);
    }

    try {
      await storageRef.child("$groupId/hello.jpg").putFile(file);
    } on Error catch (e) {}
  }


  downloadFile() async {
    // File file = await image;
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String filePath = '${appDocDir.absolute}/file-to-upload.png';
//     File file = File(filePath);

    String groupName = 'test'; //BYT TILL GROUPID
  
    int index = 0;


// Create a reference with an initial file path and name
final pathReference = storageRef.child("$groupName/$index.jpg");

// Create a reference to a file from a Google Cloud Storage URI
final gsReference =
    FirebaseStorage.instance.refFromURL("gs://mytake-a7a56.appspot.com/$groupName/$index.jpg");

// Create a reference from an HTTPS URL
// Note that in the URL, characters are URL escaped!
final httpsReference = FirebaseStorage.instance.refFromURL(
    "https://firebasestorage.googleapis.com/b/gs://mytake-a7a56.appspot.com/o/$groupName%20$index.jpg");



    var storageRefList = await (storageRef.child(groupName).listAll());
    print(storageRefList.items);
    print(storageRefList.items[0].fullPath);
    
    final imageUrl =
    
    await storageRef.child("$groupName'/'$index}").getDownloadURL();



    // for (var item in storageRefList.items) {
    //   print(item.fullPath);
    // }

    // try {
    //   await storageRef.child("$groupName/hello.jpg").putFile(file);
    // } on Error catch (e) {}
    return imageUrl;
  }
}

TestGit(jacob) {
  print('hello jacob');
}
