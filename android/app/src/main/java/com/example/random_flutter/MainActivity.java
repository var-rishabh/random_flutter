package com.example.random_flutter;

import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static final String AUDIO_COMPRESSOR_CHANNEL = "audio_compressor";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        // Audio Compressor method channel
        final MethodChannel audioCompressorChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), AUDIO_COMPRESSOR_CHANNEL);
        audioCompressorChannel.setMethodCallHandler(new AudioCompressorService());
    }
}