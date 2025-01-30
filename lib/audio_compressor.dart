import 'package:flutter/services.dart';

class AudioCompressor {
  static const MethodChannel _channel = MethodChannel('audio_compressor');

  static Future<String?> compressAudio(String inputPath, String outputPath) async {
    try {
      final String? result = await _channel.invokeMethod('compressAudio', {
        'inputPath': inputPath,
        'outputPath': outputPath,
      });
      return result;
    } on PlatformException catch (e) {
      print("Failed to compress audio: '${e.message}'.");
      return null;
    }
  }
}