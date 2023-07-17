

import 'package:expensetracker/models/expense_model.dart';
import 'package:expensetracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 21),
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: secondarystackBehindDismiss(),
          secondaryBackground: secondarystackBehindDismiss(),
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            
              onRemoveExpense(expenses[index]);
           
          },
          child: ExpenseItem(
            expenseItem: expenses[index],
          ),
        ),
      ),
    );
  }
}

Widget secondarystackBehindDismiss() {
  return Container(
    color: Colors.red,
    child: const Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete, color: Colors.white),
          Text('Move to trash', style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}
