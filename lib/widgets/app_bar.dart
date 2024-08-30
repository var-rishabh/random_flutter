import 'package:flutter/material.dart';

AppBar buildCustomAppBar({
  required BuildContext context,
  required VoidCallback onAddPressed,
}) {
  return AppBar(
    backgroundColor: Theme.of(context).primaryColorDark,
    foregroundColor: Colors.white,
    title: const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text('Expenses'),
    ),
    actions: [
      IconButton(
        padding: const EdgeInsets.only(right: 15),
        icon: const Icon(Icons.add),
        onPressed: onAddPressed,
      ),
    ],
  );
}
