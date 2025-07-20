import 'package:flutter/material.dart';

import '../model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final double? enteredAmount = double.tryParse(_amountController.text);
    final bool amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          icon: Icon(Icons.error),
          content: const Text(
            "Please make sure a valid title, amount, date and category was entered!",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }

    // Save Expense...
    final Expense newExpense = Expense(
      title: _titleController.text.trim(),
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );

    widget.onAddExpense(newExpense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.fromLTRB(16, 80, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: "CHF ",
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "No date selected"
                          : dateFormatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Row(
                          children: [
                            Icon(categoryIcons[category]),
                            SizedBox(width: 4),
                            Text(category.name.toUpperCase()),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (category) {
                  if (category == null) return;
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
