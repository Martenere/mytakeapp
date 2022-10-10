import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:android_id/android_id.dart';

Future<String?> getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    var _androidIdPlugin = AndroidId();
    var _androidId = 'Unknown';
    try {
      _androidId = await _androidIdPlugin.getId() ?? 'Unknown ID';
    } on Error {
      _androidId = 'Failed to get Android ID.';
    }

    return _androidId; // unique ID on Android
  }
  return "";
}
