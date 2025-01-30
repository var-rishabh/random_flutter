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
    if (await Permission.audio.request().isDenied) {
      await Permission.audio.request();
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
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Audio Compressor'),
        ),
        body: Center(
          child: _isCompressing
              ? CircularProgressIndicator() // Show loader if compressing
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isCompressing = true; // Start showing loader
                    });

                    try {
                      final String? result = await _channel.invokeMethod('compressAudio', {
                        'inputPath': "/storage/emulated/0/Download/gori.aac",
                        'outputPath': "/storage/emulated/0/Download/output.aac",
                        'bitRate': 12,
                      });

                      print(result);
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
