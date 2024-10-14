import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeLocation extends StatefulWidget {
  const NativeLocation({super.key});

  @override
  State<NativeLocation> createState() => _NativeLocationState();
}

class _NativeLocationState extends State<NativeLocation> {
  static const locationChannel = MethodChannel('locationChannel');
  String _location = 'Unknown location.';

  Future<void> _getLocation() async {
    String location;
    try {
      final String result =
          await locationChannel.invokeMethod('getUserLocation');
      location = 'Location: $result';
    } on PlatformException catch (e) {
      location = "Failed to get location: '${e.message}'.";
    }

    setState(() {
      _location = location;
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _getLocation,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade900,
            ),
            child: const Text(
              'Get Location',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _location,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
