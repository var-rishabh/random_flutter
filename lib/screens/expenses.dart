import 'package:flutter/material.dart';

// screens
import 'package:random_flutter/screens/components/expense_list.dart';
import 'package:random_flutter/screens/components/expense_form.dart';

// utils
import 'package:random_flutter/utils/constants/sample_expenses.dart';
import 'package:random_flutter/utils/models/expense.dart';

// widgets
import 'package:random_flutter/widgets/app_bar.dart';
import 'package:random_flutter/widgets/no_data.dart';
import 'package:random_flutter/widgets/snack_bar.dart';
import 'package:random_flutter/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _sampleExpenses = sampleExpenses;

  // open add expense modal
  void _openAddExpenseModal() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (ctx) => ExpenseForm(_addExpense),
    );
  }

  // add expense to the list
  void _addExpense(Expense expense) {
    setState(() {
      _sampleExpenses.add(expense);
    });
  }

  // delete expense from the list
  void _deleteExpense(Expense expense) {
    var expenseIndex = _sampleExpenses.indexOf(expense);
    setState(() {
      _sampleExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      buildUndoSnackBar(
        message: 'Expense deleted successfully.',
        onUndo: () {
          setState(() {
            _sampleExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildCustomAppBar(
        context: context,
        onAddPressed: _openAddExpenseModal,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            Chart(expenses: _sampleExpenses),
            _sampleExpenses.isEmpty
                ? const NoDataWidget()
                : Expanded(
                    child: ExpenseList(
                      expenses: _sampleExpenses.reversed.toList(),
                      deleteExpense: _deleteExpense,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
