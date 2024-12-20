import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import '../services/deviceid_service.dart';

class DeviceInfoId extends StatefulWidget {
  const DeviceInfoId({super.key});

  @override
  State<DeviceInfoId> createState() => _DeviceInfoIdState();
}

class _DeviceInfoIdState extends State<DeviceInfoId> {
  String? deviceId; // Variable to store the device ID

  @override
  void initState() {
    super.initState();
    fetchDeviceId(); // Fetch the device ID when the widget initializes
  }

  // Fetch the device ID
  Future<void> fetchDeviceId() async {
    String? id;

    try {
      id = await DeviceId().getDeviceId();
    } catch (e) {
      id = 'Error fetching device ID: $e';
    }

    print(id);
    // Update the state with the fetched device ID
    setState(() {
      deviceId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Device Info App'),
        ),
        body: Center(
          child: deviceId == null
              ? const CircularProgressIndicator() // Show a loader while fetching the ID
              : Text(
                  'Device ID: $deviceId',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
        ),
      ),
    );
  }
}
