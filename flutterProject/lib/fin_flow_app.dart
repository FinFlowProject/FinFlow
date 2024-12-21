import 'package:finflow/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:finflow/routes/routes.dart';

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
    Category('Food', 10),
    Category('Home', 10),
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
    Category('Salary', 15),
    Category('Deposits', 10),
    Category('Presents', 0),
    Category('Lottery', 0),
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
  final String category;
  final double amount;
  final DateTime dateTime;
  final String comment;
  Transaction(this.category, this.amount, this.dateTime, this.comment);
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
