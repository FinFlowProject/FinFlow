import 'dart:convert';

import 'package:finflow/features/local_storage/save_data.dart';
import 'package:finflow/fin_flow_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<CategoryNew>> getCategories() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? categoriesJson = prefs.getStringList('categories');
  print('Loaded categories JSON: $categoriesJson'); // Логирование
  if (categoriesJson != null) {
    return categoriesJson.map((category) => CategoryNew.fromJson(json.decode(category))).toList();
  }
  return [];
}

Future<List<Transaction>> getTransactions() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? transactionsJson = prefs.getStringList('transactions');
  print('Loaded transactions JSON: $transactionsJson'); // Логирование
  if (transactionsJson != null) {
    return transactionsJson.map((transaction) => Transaction.fromJson(json.decode(transaction))).toList();
  }
  return [];
}


// Future<List<String>> getExpensesCategories() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getStringList('expenses_categories') ?? [];
// }
