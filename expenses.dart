import 'package:flutter/material.dart';

// import 'package:expense_tracker/widgets/new_expense.dart';
// import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
// import 'package:expense_tracker/models/expense.dart';
// import 'package:expense_tracker/widgets/chart/chart.dart';

import '../models/expense.dart';
import 'chart/chart.dart';
import 'expenses_list/expenses_list.dart';
import 'new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Shopping',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leasure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: MediaQuery.of(ctx).viewInsets,
        child: NewExpense(onAddExpense: _addExpense),
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.9),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    final Widget mainContent = _registeredExpenses.isEmpty
        ? Center(
      child: Text(
        'No expenses found. Start adding some!',
        style: TextStyle(
          color: colors.onBackground,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    )
        : ExpensesList(
      expenses: _registeredExpenses,
      onRemoveExpense: _removeExpense,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Chart(expenses: _registeredExpenses),
                ),
              ),
              Expanded(child: mainContent),
            ],
          ),
        ),
      ),
    );
  }
}
