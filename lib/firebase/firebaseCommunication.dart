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
  late final Reference storageRef;

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

    String groupId = group.id;
    int pti = group.pictureTakerIndex;
    String pictureTakerIndex = pti.toString();

    // var storageRefList = await (storageRef.child(groupId).listAll());
    // print(storageRefList.items[0].fullPath);
    // for (var item in storageRefList.items) {
    //   print(item.fullPath);
    // }

    try {
      await storageRef.child("$groupId/$pictureTakerIndex.jpg").putFile(file);
    } on Error catch (e) {}
  }

  Future<List> downloadFile(Group group) async {
    List imagesUrl = [];
    var storageRefList = await (storageRef.child(group.id).listAll());

// CHANGE 2 into group.pictureLimit
    for (var i = 0; i < group.pictureLimit; i++) {
      var path = storageRefList.items[i].fullPath;
      var imageUrl = await storageRef.child('$path').getDownloadURL();
      imagesUrl.add(imageUrl);
    }
    return imagesUrl;
  }

  Future<String> getLatestGroupImageURL(Group group) async {
    
    ListResult storageRefList = await (storageRef.child(group.id).listAll());


    String path = storageRefList.items.last.fullPath;
    String imageUrl = await storageRef.child('$path').getDownloadURL();
      
    
    return imageUrl;
  }
}

TestGit(jacob) {
  print('hello jacob');
}
