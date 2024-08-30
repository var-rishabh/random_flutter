import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

const uuid = Uuid();

enum Category {
  bills,
  education,
  entertainment,
  health,
  food,
  others,
  personal,
  shopping,
  travel,
}

const categoryIcons = {
  Category.bills: Icons.receipt,
  Category.education: Icons.school,
  Category.entertainment: Icons.movie,
  Category.health: Icons.local_hospital,
  Category.food: Icons.fastfood,
  Category.others: Icons.category,
  Category.personal: Icons.person,
  Category.shopping: Icons.shopping_cart,
  Category.travel: Icons.flight,
};

const months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

String formattedDate(DateTime date) {
  return '${date.day} ${months[date.month]}, ${date.year}';
}

String formattedDateShort(DateTime date) {
  return '${date.day} ${months[date.month].substring(0, 3)}, ${date.year}';
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formatDate => formattedDate(date);
}
