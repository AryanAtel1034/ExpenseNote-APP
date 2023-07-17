import 'package:expensetracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expenseItem});

  final ExpenseModel expenseItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Card(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.lightBlue,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expenseItem.title,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.currency_rupee_sharp,
                    color: Color.fromARGB(188, 0, 0, 0),
                    size: 14,
                  ),
                  Text(
                    (expenseItem.amount).toStringAsFixed(2),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        categoryIcon[expenseItem.category],
                        color: const Color.fromARGB(188, 0, 0, 0),
                        size: 22,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        expenseItem.formattDate,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
