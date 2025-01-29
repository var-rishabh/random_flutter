import 'dart:async';
import 'package:flutter/services.dart';

class AudioCompressor {
  static const MethodChannel _channel = MethodChannel('audio_compressor');

  static Future<String?> compressAAC(String inputPath, String outputPath, int bitrate) async {
    try {
      return await _channel.invokeMethod<String>('compressAAC', {
        'inputPath': inputPath,
        'outputPath': outputPath,
        'bitrate': bitrate,
      });
    } on PlatformException catch (e) {
      print("Error compressing AAC: ${e.message}");
      return null;
    }
  }
}
