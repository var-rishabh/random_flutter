package com.example.random_flutter;

import com.arthenica.ffmpegkit.FFmpegKit;
import com.arthenica.ffmpegkit.ReturnCode;

public class AudioCompressor {

    public interface CompressionListener {
        void onCompressionComplete(String outputPath);
        void onCompressionFailed(String error);
    }

    public static void compressAudio(String inputPath, String outputPath, CompressionListener listener) {
        String command = "-i " + inputPath + " -b:a 8k " + outputPath;
        FFmpegKit.executeAsync(command, session -> {
            ReturnCode returnCode = session.getReturnCode();

            if (ReturnCode.isSuccess(returnCode)) {
                listener.onCompressionComplete(outputPath);
            } else {
                listener.onCompressionFailed("Compression failed with return code: " + returnCode);
            }
        });
    }
}