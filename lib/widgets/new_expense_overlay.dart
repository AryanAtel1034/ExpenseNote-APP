import 'dart:io';

import 'package:expensetracker/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseOverlay extends StatefulWidget {
  const ExpenseOverlay({super.key, required this.addExpense});
  final void Function(ExpenseModel expenseData) addExpense;
  @override
  State<ExpenseOverlay> createState() {
    return _ExpenseOverlayState();
  }
}

class _ExpenseOverlayState extends State<ExpenseOverlay> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.lesuire;
  DateTime? _dateTime;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _dateTime = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              "Please ensure you entered valid title,date and amount."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'OKAY',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              "Please ensure you entered valid title,date and amount."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'OKAY',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final validAmoutnt = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        validAmoutnt ||
        _dateTime == null) {
      _showDialog();

      return;
    }
    widget.addExpense(
      ExpenseModel(
        amount: enteredAmount,
        date: _dateTime!,
        title: _titleController.text,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final keyBordSize = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Container(
        padding: width < 600
            ? EdgeInsets.fromLTRB(25, 25, 25, keyBordSize + 25)
            : EdgeInsets.fromLTRB(16, 48, 16, keyBordSize + 16),
        child: Column(
          mainAxisSize: width > 600 ? MainAxisSize.max : MainAxisSize.min,
          children: [
            TextFormField(
              maxLength: 50,
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Title',
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '₹  ',
                      border: OutlineInputBorder(),
                      labelText: 'Enter Amount',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _dateTime == null
                            ? 'Select Date'
                            : formatter.format(_dateTime!),
                      ),
                      IconButton(
                        onPressed: () {
                          _presentDatePicker();
                        },
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    value: _selectedCategory,
                    iconSize: 25,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(
                        () {
                          _selectedCategory = value;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: _submitExpenseData,
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  width: 0.5,
                  color: Colors.black,
                ),
              ),
              child: const Text('Save Expense'),
            ),
            SizedBox(
              width: 107,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 0.5,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
