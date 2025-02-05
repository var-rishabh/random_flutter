package com.example.random_flutter;

import android.util.Log;

import androidx.annotation.NonNull;

import com.arthenica.ffmpegkit.FFmpegKit;
import com.arthenica.ffmpegkit.ReturnCode;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AudioCompressorService implements MethodChannel.MethodCallHandler {
    private static final String TAG = "Runo Audio Compressor";
    private static final String BITRATE = "12k";
    private static final String CHANNELS = "1";
    private static final String SAMPLE_RATE = "8000";

    @Override
    public void onMethodCall(MethodCall call, @NonNull MethodChannel.Result result) {
        if ("compressAudio".equals(call.method)) {
            String inputPath = call.argument("inputPath");
            String outputPath = call.argument("outputPath");

            if (inputPath == null || outputPath == null) {
                Log.e(TAG, "Invalid input or output path for audio compression.");
                result.success(1);
                return;
            }

            compressAudio(inputPath, outputPath, result);
        } else {
            result.notImplemented();
        }
    }

    private void compressAudio(String inputPath, String outputPath, MethodChannel.Result result) {
        String command = String.format("-i %s -b:a %s -ac %s -ar %s -y %s", inputPath, BITRATE, CHANNELS, SAMPLE_RATE, outputPath);

        Log.d(TAG, "Executing FFmpeg command: " + command);

        try {
            ReturnCode returnCode = FFmpegKit.execute(command).getReturnCode();

            if (ReturnCode.isSuccess(returnCode)) {
                Log.d(TAG, "Compression successful: " + outputPath);
                result.success(0);
            } else {
                String errorMessage = "Compression failed with code: " + returnCode;
                Log.e(TAG, errorMessage);
                result.success(1);
            }
        } catch (Exception e) {
            Log.e(TAG, "Error during compression", e);
            result.success(1);
        }
    }
}