import 'dart:convert';

import 'package:finflow/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:finflow/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Category {
  String name;
  double value;

  Category(this.name, this.value);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.name == name && other.value == value;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode;

  Map<String, dynamic> toJson() => {
    'name': name,
    'value': value,
  };
}

class Expenses {
  Expenses._privateConstructor();
  static final Expenses instance = Expenses._privateConstructor();

  void addValueByName(String name, double value) {
    for (var category in expenses) {
      if (category.name == name) {
        category.value += value;
        break;
      }
    }
  }

   List<Category> expenses = [
  //   Category('Food', 10),
  //   Category('Home', 10),
    //Category('Health', 0),
    //Category('Gifts', 0),
    //Category('Add category', 0)
  ];
}

class Income {
  Income._privateConstructor();
  static final Income instance = Income._privateConstructor();

  void addValueByName(String name, double value) {
    for (var category in income) {
      if (category.name == name) {
        category.value += value;
        break;
      }
    }
  }

  List<Category> income = [
  //   Category('Salary', 15),
  //   Category('Deposits', 10),
  //   Category('Presents', 10),
  //   Category('Lottery', 10),
  ];
}

class History {
  History._privateConstructor();
  static final History instance = History._privateConstructor();

  // void addValueByName(String name, double value) {
  //   for (var category in expenses) {
  //     if (category.name == name) {
  //       category.value += value;
  //       break;
  //     }
  //   }
  // }

  List<Transaction> history = [];

  // List<Category> expenses = [
  //   Category('Food', 10),
  //   Category('Home', 10),
  //   //Category('Health', 0),
  //   //Category('Gifts', 0),
  //   //Category('Add category', 0)
  // ];
}

class Transaction {
  String categoryName;
  String type;
  double amount;
  DateTime transactionDate;
  String description;

  Transaction(this.categoryName, this.type, this.amount, this.transactionDate, this.description);

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      json['categoryName'] as String,
      json['type'] as String,
      (json['amount'] as num).toDouble(),
      (json['transactionDate']).toIso8601String(),
      json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'categoryName': categoryName,
    'type': type,
    'amount': amount,
    'transactionDate': transactionDate,
    'description': description,
  };
}

Future<void> saveTransaction(Transaction transaction) async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? transactions = prefs.getStringList('transactions') ?? [];
  transactions.add(jsonEncode(transaction.toJson()));
  await prefs.setStringList('transactions', transactions);
}

Future<void> deleteTransaction(Transaction transaction) async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? transactions = prefs.getStringList('transactions') ?? [];
  transactions.remove(jsonEncode(transaction.toJson()));
  await prefs.setStringList('transactions', transactions);
}

class FinFlow extends StatelessWidget {
  const FinFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinFlow',
      theme: lightTheme,
      routes: routes,
    );
  }
}
