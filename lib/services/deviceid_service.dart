import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceId {
  Future<String?> getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        return androidInfo.id; // Unique Android ID
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        return iosInfo.identifierForVendor; // Unique iOS ID
      }
    } catch (e) {
      print('Error fetching device ID: $e');
    }
    return null; // If the platform is not supported or an error occurs
  }
}
