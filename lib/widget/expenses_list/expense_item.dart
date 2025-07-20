import 'package:flutter/material.dart';

import '../../model/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text("CHF ${expense.amount.toStringAsFixed(2)}"),
                const Spacer(),
                Row(
                  children: [
                    expense.icon,
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
