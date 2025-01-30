package com.example.random_flutter;

import android.media.MediaCodec;
import android.media.MediaFormat;
import android.media.MediaCodecInfo;
import android.media.MediaExtractor;
import android.media.MediaMuxer;
import android.util.Log;

import java.io.IOException;
import java.nio.ByteBuffer;

public class AudioCompressor {
    private static final String TAG = "AudioCompressor";

    public static void compressAudio(String inputPath, String outputPath, int bitRate) {
        Log.i(TAG, "Compressing audio started ...");

        // Media extraction
        MediaExtractor extractor = new MediaExtractor();
        MediaCodec decoder = null;
        MediaCodec encoder = null;
        MediaMuxer muxer = null;
        int audioTrackIndex = -1;

        try {
            extractor.setDataSource(inputPath);
            int trackCount = extractor.getTrackCount();
            Log.d(TAG, "Track count: " + trackCount);
            if (trackCount != 1) {
                Log.e(TAG, "No audio track found.");
                return;
            }
            Log.i(TAG, "Audio track found.");

            extractor.selectTrack(0);

            // Get the media info
            MediaFormat format = extractor.getTrackFormat(0);
            String mime = format.getString(MediaFormat.KEY_MIME);
            int sampleRate = format.getInteger(MediaFormat.KEY_SAMPLE_RATE);
            int channelCount = format.getInteger(MediaFormat.KEY_CHANNEL_COUNT);
            int bitRates = format.getInteger(MediaFormat.KEY_BIT_RATE);
            Log.d(TAG, "Audio Mime: " + mime + ", SampleRate: " + sampleRate + ", ChannelCount: " + channelCount + ", BitRate: " + bitRates);

            // Decode the audio data
            decoder = MediaCodec.createDecoderByType(mime);
            decoder.configure(format, null, null, 0);
            decoder.start();
            Log.i(TAG, "Decoder started.");

            // Encode the audio to AAC
            MediaFormat outputFormat = MediaFormat.createAudioFormat(MediaFormat.MIMETYPE_AUDIO_AAC, sampleRate, channelCount);
            outputFormat.setInteger(MediaFormat.KEY_BIT_RATE, bitRate); // Use the provided bitrate
            outputFormat.setInteger(MediaFormat.KEY_AAC_PROFILE, MediaCodecInfo.CodecProfileLevel.AACObjectLC);
            outputFormat.setInteger(MediaFormat.KEY_MAX_INPUT_SIZE, 1024 * 1024); // Set max input size

            encoder = MediaCodec.createEncoderByType(MediaFormat.MIMETYPE_AUDIO_AAC);
            encoder.configure(outputFormat, null, null, MediaCodec.CONFIGURE_FLAG_ENCODE);
            encoder.start();
            Log.i(TAG, "Encoder started.");

            // Set up MediaMuxer for writing the output file
            muxer = new MediaMuxer(outputPath, MediaMuxer.OutputFormat.MUXER_OUTPUT_MPEG_4);
            boolean muxerStarted = false;
            Log.i(TAG, "Muxer created.");

            // Buffer setup
            MediaCodec.BufferInfo decoderBufferInfo = new MediaCodec.BufferInfo();
            MediaCodec.BufferInfo encoderBufferInfo = new MediaCodec.BufferInfo();
            boolean isDecodingComplete = false;
            boolean isEncodingComplete = false;

            while (!isEncodingComplete) {
                // Decode input
                if (!isDecodingComplete) {
                    int inputBufferIndex = decoder.dequeueInputBuffer(10000); // 10ms timeout
                    if (inputBufferIndex >= 0) {
                        ByteBuffer inputBuffer = decoder.getInputBuffer(inputBufferIndex);
                        if (inputBuffer != null) {
                            int sampleSize = extractor.readSampleData(inputBuffer, 0);
                            if (sampleSize > 0) {
                                decoder.queueInputBuffer(inputBufferIndex, 0, sampleSize, extractor.getSampleTime(), 0);
                                extractor.advance();
                            } else {
                                // End of stream
                                decoder.queueInputBuffer(inputBufferIndex, 0, 0, 0, MediaCodec.BUFFER_FLAG_END_OF_STREAM);
                                isDecodingComplete = true;
                                Log.i(TAG, "Decoder EOS reached.");
                            }
                        }
                    }
                }

                // Decode output
                int outputBufferIndex = decoder.dequeueOutputBuffer(decoderBufferInfo, 10000);
                if (outputBufferIndex >= 0) {
                    ByteBuffer outputBuffer = decoder.getOutputBuffer(outputBufferIndex);
                    if (outputBuffer != null) {
                        // Pass decoded raw PCM data to the encoder
                        encodeAudio(encoder, outputBuffer, decoderBufferInfo);
                        decoder.releaseOutputBuffer(outputBufferIndex, false);
                    }
                } else if (outputBufferIndex == MediaCodec.INFO_OUTPUT_FORMAT_CHANGED) {
                    MediaFormat newFormat = decoder.getOutputFormat();
                    Log.d(TAG, "Decoder output format changed: " + newFormat);
                }

                // Encode output
                int encoderOutputBufferIndex = encoder.dequeueOutputBuffer(encoderBufferInfo, 10000);
                if (encoderOutputBufferIndex >= 0) {
                    ByteBuffer encoderOutputBuffer = encoder.getOutputBuffer(encoderOutputBufferIndex);
                    if (encoderOutputBuffer != null) {
                        if ((encoderBufferInfo.flags & MediaCodec.BUFFER_FLAG_CODEC_CONFIG) != 0) {
                            // Ignore codec config data
                            encoderBufferInfo.size = 0;
                        }

                        if (encoderBufferInfo.size > 0) {
                            if (!muxerStarted) {
                                // Start the muxer after getting the encoder's output format
                                MediaFormat encoderFormat = encoder.getOutputFormat();
                                audioTrackIndex = muxer.addTrack(encoderFormat);
                                muxer.start();
                                muxerStarted = true;
                                Log.i(TAG, "Muxer started.");
                            }

                            muxer.writeSampleData(audioTrackIndex, encoderOutputBuffer, encoderBufferInfo);
                        }

                        encoder.releaseOutputBuffer(encoderOutputBufferIndex, false);

                        if ((encoderBufferInfo.flags & MediaCodec.BUFFER_FLAG_END_OF_STREAM) != 0) {
                            isEncodingComplete = true;
                            Log.i(TAG, "Encoder EOS reached.");
                        }
                    }
                } else if (encoderOutputBufferIndex == MediaCodec.INFO_OUTPUT_FORMAT_CHANGED) {
                    MediaFormat newFormat = encoder.getOutputFormat();
                    Log.d(TAG, "Encoder output format changed: " + newFormat);
                }
            }

            Log.i(TAG, "Compression completed successfully.");
        } catch (IOException e) {
            Log.e(TAG, "Error during audio compression: " + e.getMessage(), e);
        } finally {
            if (decoder != null) {
                decoder.stop();
                decoder.release();
            }
            if (encoder != null) {
                encoder.stop();
                encoder.release();
            }
            if (muxer != null) {
                muxer.stop();
                muxer.release();
            }
            extractor.release();
        }
    }

    private static void encodeAudio(MediaCodec encoder, ByteBuffer inputBuffer, MediaCodec.BufferInfo bufferInfo) {
        int inputBufferIndex = encoder.dequeueInputBuffer(10000); // 10ms timeout
        if (inputBufferIndex >= 0) {
            ByteBuffer encoderInputBuffer = encoder.getInputBuffer(inputBufferIndex);
            if (encoderInputBuffer != null) {
                encoderInputBuffer.clear();
                encoderInputBuffer.put(inputBuffer);
                encoder.queueInputBuffer(inputBufferIndex, 0, bufferInfo.size, bufferInfo.presentationTimeUs, 0);
            }
        }
    }
}