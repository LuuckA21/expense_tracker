import 'package:expense_tracker/widget/chart/chart.dart';
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
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addNewExpense),
    );
  }

  void _addNewExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final int expenseIndex = expenses.indexOf(expense);
    setState(() {
      expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text("Expense deleted."),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              expenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some!"),
    );

    if (expenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: expenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: expenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
