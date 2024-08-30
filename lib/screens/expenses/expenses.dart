import 'package:flutter/material.dart';

import 'package:random_flutter/constants/sample_expenses.dart';
import 'package:random_flutter/models/expense.dart';
import 'package:random_flutter/screens/expenses/components/expense_list.dart';
import 'package:random_flutter/screens/expenses/components/expense_form.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _sampleExpenses = sampleExpenses;

  void _openAddExpenseModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => ExpenseForm(_addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _sampleExpenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    setState(() {
      _sampleExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
            onPressed: () {
              _openAddExpenseModal();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: _sampleExpenses.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://img.freepik.com/free-vector/hand-drawn-no-data-concept_52683-127823.jpg',
                      height: 250,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'No expenses added yet.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            : ExpenseList(
                expenses: _sampleExpenses.reversed.toList(),
                deleteExpense: _deleteExpense,
              ),
      ),
    );
  }
}
