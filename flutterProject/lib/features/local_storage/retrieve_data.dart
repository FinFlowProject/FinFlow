import 'package:shared_preferences/shared_preferences.dart';


Future<List<String>> getTransactions() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('transactions') ?? [];
}

Future<List<String>> getIncomeCategories() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('income_categories') ?? [];
}

Future<List<String>> getExpensesCategories() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('expenses_categories') ?? [];
}