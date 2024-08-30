import 'package:flutter/material.dart';

import 'package:random_flutter/models/expense.dart';

class ExpenseForm extends StatefulWidget {
  final void Function(Expense) addExpense;

  const ExpenseForm(this.addExpense, {super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController(text: '0.0');
  DateTime? _selectedDate = DateTime.now();
  Category? _selectedCategory = Category.others;

  void selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void selectCategory(Category category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _submitForm() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please enter valid title, amount and date.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
      return;
    }

    final newExpense = Expense(
      title: title,
      amount: amount,
      date: _selectedDate!,
      category: _selectedCategory!,
    );

    widget.addExpense(newExpense);

    Navigator.pop(context, newExpense);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: isKeyboardOpen ? MainAxisSize.max : MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add Expense',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            maxLength: 30,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : formattedDateShort(_selectedDate!),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    IconButton(
                      onPressed: selectDate,
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Row(
                      children: [
                        Icon(categoryIcons[item]),
                        const SizedBox(width: 10),
                        Text(item.name.toUpperCase()),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  selectCategory(value as Category);
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).secondaryHeaderColor,
                backgroundColor: Theme.of(context).primaryColorDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}
