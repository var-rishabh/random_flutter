import 'package:flutter/material.dart';

// screens
import 'package:random_flutter/screens/expenses.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Expenses(),
    )
  );
}