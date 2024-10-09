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

    return Container(
      alignment:
          pickImage.image == null ? Alignment.center : Alignment.centerLeft,
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: pickImage.image == null ? Colors.grey : Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: pickImage.image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                pickImage.image!,
              ),
            )
          : TextButton.icon(
              style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: pickImage.captureImage,
              label: const Text(
                'Open Camera',
                style: TextStyle(fontSize: 20, color: Colors.blueGrey),
              ),
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.blueGrey,
              ),
            ),
    );
  }
}
