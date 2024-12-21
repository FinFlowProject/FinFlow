//import 'package:finflow/features/add_expenses/view.dart';
import 'package:finflow/features/add_smth/add_smth_screen.dart';
import 'package:finflow/features/authorization/view/authorization_screen.dart';
import 'package:finflow/features/choose_category/view.dart';
import 'package:finflow/features/home_page/view.dart';
//import '../features/add_expenses/category/add_category/view.dart';
import '../features/add_category/view.dart';
//import '../features/add_expenses/category/view.dart';
//import '../features/add_income/category/view.dart';
//import '../features/add_income/view.dart';
//import '../features/add_income/category/add_category/view.dart';
import '../features/delete_category/view.dart';
import '../features/transaction_history/view.dart';

final routes = {
  '/': (context) => const HomePage(title: 'FinFlow',),
  '/add_expenses': (context) => const AddSmth(title: 'Add Expenses'),
  '/add_expenses/category': (context) => const ChooseCategory(title: 'Choose category'),
  '/add_expenses/category/add_category': (context) => const AddCategory(title: 'Add category'),
  '/add_income': (context) => const AddSmth(title: 'Add Income'),
  '/add_income/category': (context) => const ChooseCategory(title: 'Choose category'),
  '/add_income/category/add_category': (context) => const AddCategory(title: 'Add category'),
  '/authorization' : (context) => const AuthorizationScreen(title: 'Authorization'),
  '/delete_category_expenses' : (context) => const DeleteCategory(title: 'Choose category'),
  '/delete_category_income' : (context) => const DeleteCategory(title: 'Choose category'),
  '/history' : (context) => const TransactionsHistory(title: 'History',),
};