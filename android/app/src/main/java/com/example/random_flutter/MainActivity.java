package com.example.random_flutter;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import androidx.annotation.NonNull;

import android.os.BatteryManager;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationManager;
import android.provider.Settings;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

public class MainActivity extends FlutterActivity {
    private static final String BATTERY_CHANNEL = "batteryChannel";
    private static final String LOCATION_CHANNEL = "locationChannel";
    private static final int REQUEST_CODE_LOCATION_PERMISSION = 1;
    private static final int REQUEST_CODE_LOCATION_SETTINGS = 2;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        // Battery Channel
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), BATTERY_CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getBatteryLevel")) {
                                int batteryLevel = getBatteryLevel();
                                if (batteryLevel != -1) {
                                    result.success(batteryLevel);
                                } else {
                                    result.error("UNAVAILABLE", "Battery level not available.", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );

        // Location Channel
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), LOCATION_CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getUserLocation")) {
                                if (checkLocationPermission()) {
                                    if (isLocationEnabled()) {
                                        String location = getLocation();
                                        result.success(location);
                                    } else {
                                        enableLocationServices();
                                        result.error("LOCATION_DISABLED", "Location services are disabled.", null);
                                    }
                                } else {
                                    requestLocationPermission();
                                    result.error("PERMISSION_NOT_GRANTED", "Location permission not granted.", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private int getBatteryLevel() {
        BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    }

    private boolean checkLocationPermission() {
        return ContextCompat.checkSelfPermission(this,
                android.Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED;
    }

    private void requestLocationPermission() {
        if (!checkLocationPermission()) {
            ActivityCompat.requestPermissions(this,
                    new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION},
                    REQUEST_CODE_LOCATION_PERMISSION);
        }
    }

    private boolean isLocationEnabled() {
        LocationManager locationManager = (LocationManager) getSystemService(LOCATION_SERVICE);
        return locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER) ||
                locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER);
    }

    private void enableLocationServices() {
        Intent intent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
        startActivityForResult(intent, REQUEST_CODE_LOCATION_SETTINGS);
    }

    private String getLocation() {
        LocationManager lm = (LocationManager) getSystemService(LOCATION_SERVICE);
        Location location = null;
        if (checkLocationPermission()) {
            if (isLocationEnabled()) {
                location = lm.getLastKnownLocation(LocationManager.GPS_PROVIDER);
                if (location == null) {
                    location = lm.getLastKnownLocation(LocationManager.NETWORK_PROVIDER);
                }
            }
        }
        if (location != null) {
            return location.getLatitude() + ", " + location.getLongitude();
        } else {
            return "Location not available.";
        }
    }

//    @Override
//    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
//        if (requestCode == REQUEST_CODE_LOCATION_PERMISSION) {
//            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
//                if (isLocationEnabled()) {
//                    new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), LOCATION_CHANNEL)
//                            .invokeMethod("getUserLocation", null);
//                } else {
//                    enableLocationServices();
//                }
//            }
//        }
//        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
//    }
//
//    @Override
//    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
//        if (requestCode == REQUEST_CODE_LOCATION_SETTINGS) {
//            if (isLocationEnabled()) {
//                new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), LOCATION_CHANNEL)
//                        .invokeMethod("getUserLocation", null);
//            } else {
//                enableLocationServices();
//            }
//        }
//        super.onActivityResult(requestCode, resultCode, data);
//    }
}
