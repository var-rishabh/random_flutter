import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'AudioCompressor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AAC Audio Compressor',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _outputPath;
  bool _isCompressing = false;

  Future<void> _compressAudio() async {
    await Permission.audio.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    await Permission.mediaLibrary.request();

    setState(() {
      _isCompressing = true;
      _outputPath = null;
    });


    String inputPath = "/storage/emulated/0/Download/aacJoji.aac";
    String outputPath = "/storage/emulated/0/Download/outJoji.aac";
    int bitrate = 12000;

    String? result = await AudioCompressor.compressAAC(inputPath, outputPath, bitrate);

    setState(() {
      _isCompressing = false;
      _outputPath = result;
    });

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Compression successful: $result")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Compression failed.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AAC Compressor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isCompressing ? null : _compressAudio,
              child: _isCompressing ? const CircularProgressIndicator() : const Text('Compress Audio'),
            ),
            const SizedBox(height: 20),
            if (_outputPath != null) Text("Output file: $_outputPath"),
          ],
        ),
      ),
    );
  }
}
