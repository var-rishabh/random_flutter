import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_flutter/provider/image.dart';

class OpenCamera extends StatefulWidget {
  const OpenCamera({super.key});

  @override
  State<OpenCamera> createState() => _OpenCameraState();
}

class _OpenCameraState extends State<OpenCamera> {
  @override
  Widget build(BuildContext context) {
    final UserImageProvider pickImage = Provider.of<UserImageProvider>(context);

    return TextButton.icon(
      style: ButtonStyle(
        side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(
            color: Colors.blueGrey,
            width: 1,
          ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: pickImage.captureImage,
      label: const Text(
        'Open Camera',
        style: TextStyle(color: Colors.blueGrey),
      ),
      icon: const Icon(
        Icons.camera_alt,
        color: Colors.blueGrey,
      ),
    );
  }
}
