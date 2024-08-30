import 'package:flutter/material.dart';

import 'package:random_flutter/models/expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense) deleteExpense;

  const ExpenseList({
    super.key,
    required this.expenses,
    required this.deleteExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (_) {
            deleteExpense(expenses[index]);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Card(
              color: Colors.white,
              elevation: 1,
              child: ListTile(
                title: Text(expenses[index].title),
                subtitle: Text(expenses[index].formatDate),
                trailing: Text('\$${expenses[index].amount}', style: const TextStyle(fontSize: 18)),
                leading: Icon(categoryIcons[expenses[index].category]),
              ),
            ),
          ),
        );
      },
    );
  }
}
