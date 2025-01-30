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
                                AudioCompressor.compressAudio(inputPath, outputPath, new AudioCompressor.CompressionListener() {
                                    @Override
                                    public void onCompressionComplete(String outputPath) {
                                        result.success(outputPath);
                                    }

                                    @Override
                                    public void onCompressionFailed(String error) {
                                        result.error("COMPRESSION_FAILED", error, null);
                                    }
                                });
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}