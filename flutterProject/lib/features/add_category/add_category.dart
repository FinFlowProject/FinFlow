import 'package:finflow/features/local_storage/save_data.dart';
import 'package:finflow/fin_flow_app.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key, required this.title});

  final String title;

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  List<Category> expenses = Expenses.instance.expenses;
  List<Category> income = Income.instance.income;
  List<Transaction> history = History.instance.history;

  late double value;
  late String comment;

  final TextEditingController _controller = TextEditingController();

  final Category addCategory = Category('Add category', 0);

  @override
  void initState() {
    super.initState();
    expenses.remove(addCategory);
    income.remove(addCategory);
  }

  @override
  void dispose() {
    expenses.remove(addCategory);
    income.remove(addCategory);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)!.settings.name;
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      value = args["value"];
      comment = args["comment"];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Category name',
            border: OutlineInputBorder(),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              String? categoryName = _controller.text;
              if (categoryName != '') {
                bool containsName = false;
                if (routeName == '/add_expenses/category/add_category') {
                  for (var i in expenses) {
                    if (i.name == categoryName) {
                      containsName = true;
                    }
                  }
                  if (!containsName) {
                    expenses.add(Category(categoryName, value));
                   // print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa'+expenses[1].name);
                  } else {
                    Expenses.instance.addValueByName(categoryName, value);
                  }
                  saveCategory(Category(categoryName, value));
                  history.add(Transaction(categoryName, 'expenses', value, DateTime.now(), comment));
                }
                if (routeName == '/add_income/category/add_category') {
                  for (var i in income) {
                    if (i.name == categoryName) {
                      containsName = true;
                    }
                  }
                  if (!containsName) {
                    income.add(Category(categoryName, 0));
                  }
                  Income.instance.addValueByName(categoryName, value);
                  saveCategory(Category(categoryName, value));
                  history.add(Transaction(categoryName, 'income', value, DateTime.now(), comment));
                }
                Navigator.of(context).pushNamed('/');
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("Add valid name"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Add category'))
      ]),
    );
  }
}
