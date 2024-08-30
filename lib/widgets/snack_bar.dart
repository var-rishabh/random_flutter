import 'package:flutter/material.dart';

SnackBar buildUndoSnackBar({
  required String message,
  required VoidCallback onUndo,
  Duration duration = const Duration(seconds: 2),
}) {
  return SnackBar(
    content: Text(message),
    duration: duration,
    action: SnackBarAction(
      label: 'UNDO',
      onPressed: onUndo,
    ),
  );
}
