import 'package:flutter/material.dart';
import 'audio_compressor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Audio Compressor'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              String inputPath = "/storage/emulated/0/Download/aacM.aac";
              String outputPath = "/storage/emulated/0/Download/output.aac";
              String? result = await AudioCompressor.compressAudio(inputPath, outputPath);
              if (result != null) {
                print("Audio compressed successfully: $result");
              } else {
                print("Audio compression failed");
              }
            },
            child: Text('Compress Audio'),
          ),
        ),
      ),
    );
  }
}