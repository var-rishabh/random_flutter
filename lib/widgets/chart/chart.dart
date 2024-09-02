import 'package:flutter/material.dart';

// utils
import 'package:random_flutter/utils/models/expense.dart';

// widgets
import 'package:random_flutter/widgets/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Expense> expenses;

  const Chart({super.key, required this.expenses});

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.getCategorizedExpenses(expenses, Category.bills),
      ExpenseBucket.getCategorizedExpenses(expenses, Category.education),
      ExpenseBucket.getCategorizedExpenses(expenses, Category.entertainment),
      ExpenseBucket.getCategorizedExpenses(expenses, Category.health),
      ExpenseBucket.getCategorizedExpenses(expenses, Category.food),
      ExpenseBucket.getCategorizedExpenses(expenses, Category.others),
      ExpenseBucket.getCategorizedExpenses(expenses, Category.personal),
      ExpenseBucket.getCategorizedExpenses(expenses, Category.shopping),
      ExpenseBucket.getCategorizedExpenses(expenses, Category.travel),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 10,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 226, 246, 255),
            Color.fromARGB(255, 239, 253, 255),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: Colors.blueAccent.shade200,
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
