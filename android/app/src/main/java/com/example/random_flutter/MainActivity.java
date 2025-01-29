package com.example.random_flutter;

import android.media.MediaCodec;
import android.media.MediaCodecInfo;
import android.media.MediaExtractor;
import android.media.MediaFormat;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import java.io.FileOutputStream;
import java.nio.ByteBuffer;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "audio_compressor";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("compressAAC")) {
                        String inputPath = call.argument("inputPath");
                        String outputPath = call.argument("outputPath");
                        int bitrate = call.argument("bitrate");

                        try {
                            boolean success = compressAAC(inputPath, outputPath, bitrate);
                            result.success(success ? outputPath : null);
                        } catch (Exception e) {
                            result.error("COMPRESSION_ERROR", "Error compressing AAC file", e.getMessage());
                        }
                    }
                });
    }

    private boolean compressAAC(String inputPath, String outputPath, int bitrate) {
        try {
            MediaExtractor extractor = new MediaExtractor();
            extractor.setDataSource(inputPath);

            MediaFormat format = null;
            int trackIndex = -1;

            // Find AAC track
            for (int i = 0; i < extractor.getTrackCount(); i++) {
                MediaFormat f = extractor.getTrackFormat(i);
                String mime = f.getString(MediaFormat.KEY_MIME);
                if (mime.startsWith("audio/")) {
                    format = f;
                    trackIndex = i;
                    break;
                }
            }

            if (format == null) return false;
            extractor.selectTrack(trackIndex);

            MediaCodec decoder = MediaCodec.createDecoderByType(format.getString(MediaFormat.KEY_MIME));
            decoder.configure(format, null, null, 0);
            decoder.start();

            MediaFormat outputFormat = MediaFormat.createAudioFormat("audio/mp4a-latm",
                    format.getInteger(MediaFormat.KEY_SAMPLE_RATE),
                    format.getInteger(MediaFormat.KEY_CHANNEL_COUNT));
            outputFormat.setInteger(MediaFormat.KEY_BIT_RATE, bitrate);
            outputFormat.setInteger(MediaFormat.KEY_AAC_PROFILE, MediaCodecInfo.CodecProfileLevel.AACObjectLC);

            MediaCodec encoder = MediaCodec.createEncoderByType("audio/mp4a-latm");
            encoder.configure(outputFormat, null, null, MediaCodec.CONFIGURE_FLAG_ENCODE);
            encoder.start();

            ByteBuffer[] decoderInputBuffers = decoder.getInputBuffers();
            ByteBuffer[] encoderOutputBuffers = encoder.getOutputBuffers();
            MediaCodec.BufferInfo info = new MediaCodec.BufferInfo();

            FileOutputStream outputStream = new FileOutputStream(outputPath);

            boolean endOfStream = false;
            while (!endOfStream) {
                int inputIndex = decoder.dequeueInputBuffer(10000);
                if (inputIndex >= 0) {
                    ByteBuffer buffer = decoderInputBuffers[inputIndex];
                    int sampleSize = extractor.readSampleData(buffer, 0);
                    if (sampleSize < 0) {
                        decoder.queueInputBuffer(inputIndex, 0, 0, 0, MediaCodec.BUFFER_FLAG_END_OF_STREAM);
                        endOfStream = true;
                    } else {
                        decoder.queueInputBuffer(inputIndex, 0, sampleSize, extractor.getSampleTime(), 0);
                        extractor.advance();
                    }
                }

                int outputIndex = encoder.dequeueOutputBuffer(info, 10000);
                if (outputIndex >= 0) {
                    ByteBuffer encodedData = encoderOutputBuffers[outputIndex];
                    encodedData.position(info.offset);
                    encodedData.limit(info.offset + info.size);

                    byte[] data = new byte[info.size];
                    encodedData.get(data);
                    outputStream.write(data);

                    encoder.releaseOutputBuffer(outputIndex, false);
                }
            }

            outputStream.close();
            decoder.stop();
            decoder.release();
            encoder.stop();
            encoder.release();
            extractor.release();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
