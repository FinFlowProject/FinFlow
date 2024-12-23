import 'package:dio/dio.dart';
import 'package:finflow/fin_flow_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CategoryNew {
  String name;
  String type;
  double value;

  CategoryNew(this.name, this.type, this.value);

  factory CategoryNew.fromJson(Map<String, dynamic> json) {
    return CategoryNew(
      json['name'] as String,
      json['type'] as String,
      json['value'] as double,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    'value': value,
  };
}

List<CategoryNew> mergeCategories(List<Category> expenses, List<Category> income) {
  List<CategoryNew> categoriesNew = [];
  for (int i = 0; i < expenses.length; i++) {
    categoriesNew.add(CategoryNew(expenses[i].name, 'expenses', expenses[i].value));
  }
  for (int i = 0; i < income.length; i++) {
    categoriesNew.add(CategoryNew(income[i].name, 'income', income[i].value));
  }
  return categoriesNew;
}

void splitCategories(List<CategoryNew> categoriesNew) {
  for (int i = 0; i < categoriesNew.length; i++) {
    if (categoriesNew[i].type == 'expenses') {
      Expenses.instance.expenses.add(Category(categoriesNew[i].name, categoriesNew[i].value));
    } else {
      Income.instance.income.add(Category(categoriesNew[i].name, categoriesNew[i].value));
    }
  }
}

Future<void> saveCategory(CategoryNew category) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> categories = prefs.getStringList('categories') ?? [];
  categories.add(jsonEncode(category.toJson()));
  await prefs.setStringList('categories', categories);
  print('Saved categories: $categories'); // Логирование

}



Future<void> deleteCategory(Category category) async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? categories = prefs.getStringList('categories') ?? [];
  categories.remove(jsonEncode(category.toJson()));
  await prefs.setStringList('categories', categories);
}


Future<void> saveTransaction(Transaction transaction) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> transactions = prefs.getStringList('transactions') ?? [];
  transactions.add(jsonEncode(transaction.toJson()));
  await prefs.setStringList('transactions', transactions);
  print('Saved transactions: $transactions'); // Логирование
}

Future<void> deleteTransaction(Transaction transaction) async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? transactions = prefs.getStringList('transactions') ?? [];
  transactions.remove(jsonEncode(transaction.toJson()));
  await prefs.setStringList('transactions', transactions);
}



Future<void> sendPatchRequest({
  required BuildContext context,
  required DateTime lastChangeDate,
  required List<CategoryNew> addedCategories,
  required List<Transaction> addedTransactions,
}) async {
  const url = 'http://10.0.2.2:8080/sync';
  final data = {
    'lastChangeDate': lastChangeDate.toIso8601String(),
    'categories': {
      'added': addedCategories.map((category) => category.toJson()).toList(),
    },
    'transactions': {
      'added': addedTransactions.map((transaction) => transaction.toJson()).toList(),
    },
  };

  try {
    final response = await Dio().patch(url, data: data);

    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Data synced successfully')));
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to sync data: ${response.statusMessage}')));
      }
    }
  } on DioException catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
    }
  }
}