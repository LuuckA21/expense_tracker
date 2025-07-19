import 'package:expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

import '../model/expense.dart';

final List<Expense> expenses = [
  Expense(
    title: "Parcheggio cliente",
    amount: 7.5,
    date: DateTime.utc(2025, 7, 18),
    category: Category.work,
  ),
  Expense(
    title: "Pranzo al ristorante",
    amount: 18.0,
    date: DateTime.utc(2025, 7, 17),
    category: Category.food,
  ),
  Expense(
    title: "Viaggio in treno",
    amount: 32.5,
    date: DateTime.utc(2025, 7, 16),
    category: Category.travel,
  ),
  Expense(
    title: "Cinema con amici",
    amount: 16.0,
    date: DateTime.utc(2025, 7, 15),
    category: Category.leisure,
  ),
];

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        backgroundColor: const Color.fromARGB(255, 240, 215, 160),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 253, 224),
      body: Column(
        children: [
          const Text("Chart"),
          Expanded(child: ExpensesList(expenses: expenses)),
        ],
      ),
    );
  }
}
