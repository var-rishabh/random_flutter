import 'package:flutter/material.dart';
import 'package:sip_ua/sip_ua.dart';

class Call extends StatefulWidget {
  const Call({super.key});

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  final SIPUAHelper _helper = SIPUAHelper();

  final UaSettings _settings = UaSettings();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // Call a number
          },
          child: const Text("Call"),
        ),
        ElevatedButton(
          onPressed: () {
            // Answer a call
          },
          child: const Text("Answer"),
        ),
        ElevatedButton(
          onPressed: () {
            // Hangup a call
          },
          child: const Text("Hangup"),
        ),
      ],
    );
  }
}
