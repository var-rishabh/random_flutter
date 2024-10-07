import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String optionText;
  final void Function() onTap;

  const OptionButton(
      {required this.optionText, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff06b2d0),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          minimumSize: const Size(150, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(optionText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            )),
      ),
    );
  }
}
