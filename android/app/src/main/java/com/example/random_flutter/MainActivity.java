package com.example.random_flutter;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "audio_compressor";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("compressAudio")) {
                                String inputPath = call.argument("inputPath");
                                String outputPath = call.argument("outputPath");
                                int bitRate = call.argument("bitRate");
                                AudioCompressor.compressAudio(inputPath, outputPath, bitRate);
                                result.success("Audio compressed successfully");
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}