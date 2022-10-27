import 'dart:io';


import '../models/modelGroup.dart';
import 'package:firebase_storage/firebase_storage.dart';


class FirebaseCommunication {
  late final storage;
  late final Reference storageRef;

  firebaseCommunication() {}

  void initFirebase() async {
    // Storage
    storage = FirebaseStorage.instance;
    storageRef = FirebaseStorage.instance.ref();
    // Database
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

    try {
      await storageRef.child("$groupId/$pictureTakerIndex.jpg").putFile(file);
    } on Error catch (e) {print(e);}
  }

  Future<List> downloadFile(Group group) async {
    List imagesUrl = [];
    var storageRefList = await (storageRef.child(group.id).listAll());


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
