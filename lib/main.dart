import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const MethodChannel _channel = MethodChannel('audio_compressor');
  bool _isCompressing = false;

  void askPermission() async {
    if (await Permission.storage.request().isDenied) {
      await Permission.storage.request();
    }
  }

  @override
  void initState() {
    super.initState();
    askPermission();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _isCompressing
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isCompressing = true;
                    });

                    try {
                      final String? result = await _channel.invokeMethod('compressAudio', {
                        'inputPath': "/storage/emulated/0/Download/gori.aac",
                        'outputPath': "/storage/emulated/0/Download/output.aac",
                        'bitRate': 8000,
                      });
                      print("Compressed audio path: $result");
                    } on PlatformException catch (e) {
                      print("Failed to compress audio: '${e.message}'.");
                    } finally {
                      setState(() {
                        _isCompressing = false; // Hide loader after compression
                      });
                    }
                  },
                  child: Text('Compress Audio'),
                ),
        ),
      ),
    );
  }
}
