import 'package:flutter/material.dart';
import 'package:random_flutter/Call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown.shade900,
          title: const Text(
            "RUNO X SIP",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.brown.shade100,
        body: const Center(
          child: Call(),
        ),
      ),
    );
  }
}
