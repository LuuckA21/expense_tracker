import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final DateFormat dateFormatter = DateFormat("dd.MM.yyyy");

const Uuid uuid = Uuid();

enum Category { food, travel, leisure, work }

const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

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

  String get formattedDate => dateFormatter.format(date);

  Icon get icon => Icon(categoryIcons[category] ?? Icons.help_outline);
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  const ExpenseBucket(this.category, this.expenses);

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses = allExpenses
          .where((expense) => expense.category == category)
          .toList();

  double get totalExpenses {
    double sum = 0;
    for (final Expense expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
