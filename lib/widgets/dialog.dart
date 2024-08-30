import 'package:flutter/material.dart';

class CustomDialog {
  static Future<void> showErrorDialog({
    required BuildContext context,
    required String title,
    required String content,
    String buttonText = 'Okay',
  }) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}
