import 'package:flutter/material.dart';
import 'package:random_flutter/screens/expenses/expenses.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Expenses(),
    )
  );
}