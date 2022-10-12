import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

Future<String> getId() async {
  String key = "MytakeId";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  String? id = prefs.getString(key);

  //If no key exists in prefs, randomize one and add it to ref
  if (id == null) {
    print("generate");
    id = generateRandomString(5);

    prefs.setString(key, id);
  }

  return id!;
}

String generateRandomString(int len) {
  var r = Random();
  const _chars = 'ABCDEFGHIJKLMNPQRSTUVWXYZ123456789';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}
