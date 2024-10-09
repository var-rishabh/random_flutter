import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:random_flutter/provider/image.dart';
import 'package:random_flutter/provider/location.dart';
import 'package:random_flutter/screens/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserImageProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FavLocation',
      home: HomeScreen(),
    );
  }
}
