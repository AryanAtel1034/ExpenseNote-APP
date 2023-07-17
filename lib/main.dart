import 'package:flutter/material.dart';
import 'package:expensetracker/widgets/expense.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Expense(),
    ),
  );
}
