import 'package:flutter/material.dart';
// import 'package:flutter_practice/expensive_tracker/widgets/new_expense.dart';

enum Category {
  food,
  travel,
  leasure,
  work,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leasure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  const Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}
