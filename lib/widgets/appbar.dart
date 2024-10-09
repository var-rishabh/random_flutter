import 'package:flutter/material.dart';

class KAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const KAppBar({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  State<KAppBar> createState() => _KAppBarState();
}

class _KAppBarState extends State<KAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Locations',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue.shade900,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }
}
