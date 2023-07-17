import 'package:expensetracker/widgets/expense_list/expense_list.dart';
import 'package:expensetracker/widgets/new_expense_overlay.dart';
import 'package:flutter/material.dart';
import 'package:expensetracker/models/expense_model.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expense> {
  final List<ExpenseModel> registredExpense = [
    ExpenseModel(
      amount: 499.12,
      date: DateTime.now(),
      title: "Flutter Course",
      category: Category.work,
    ),
    ExpenseModel(
      amount: 150.99,
      date: DateTime.now(),
      title: "Steam Momos",
      category: Category.food,
    ),
  ];

  void newExpenseData(ExpenseModel data) {
    setState(() {
      registredExpense.add(data);
    });
  }

  void deleteExpenseData(ExpenseModel data) {
    final _registeredIndex = registredExpense.indexOf(data);
    setState(() {
      registredExpense.remove(data);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registredExpense.insert(_registeredIndex, data);
            });
          },
        ),
      ),
    );
  }

  void _openOverLay() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => ExpenseOverlay(
        addExpense: newExpenseData,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("ExpenseTracker"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Expenses',
            onPressed: _openOverLay,
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Expanded(
                  child: ExpenseList(
                    expenses: registredExpense,
                    onRemoveExpense: deleteExpenseData,
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: ExpenseList(
                    expenses: registredExpense,
                    onRemoveExpense: deleteExpenseData,
                  ),
                ),
              ],
            ),
    );
  }
}
