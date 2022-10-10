import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

Future<String> getId() async {
  String key = "MytakeId";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  String? id = prefs.getString(key);
  if (id == null) {
    int x = Random().nextInt(3000);
    id = "asdf$x";
    prefs.setString(key, id);
  }
  return id;
}
