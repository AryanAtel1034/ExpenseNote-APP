import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, lesuire, work }

const categoryIcon = {
  Category.food: Icons.dining,
  Category.travel: Icons.flight,
  Category.lesuire: Icons.mobile_friendly,
  Category.work: Icons.work_history,
};

class ExpenseModel {
  ExpenseModel({
    required this.amount,
    required this.date,
    required this.title,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattDate {
    return formatter.format(date);
  }
}
