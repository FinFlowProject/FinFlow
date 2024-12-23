

import 'package:finflow/fin_flow_app.dart';
import 'package:flutter/material.dart';

class ChooseCategory extends StatefulWidget {
  const ChooseCategory({super.key, required this.title});

  final String title;

  @override
  State<ChooseCategory> createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  late List<Category> categories;
  List<Category> expenses = Expenses.instance.expenses;
  List<Category> income = Income.instance.income;
  List<Transaction> history = History.instance.history;
  final Category addCategory = Category('Add category', 0);

  late double value;
  late String comment;

  @override
  void initState() {
    super.initState();
    expenses.remove(addCategory);
    expenses.add(addCategory);
    income.remove(addCategory);
    income.add(addCategory);
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
    if (routeName == '/add_expenses/category') {
      categories = Expenses.instance.expenses;
      // className = Expenses;
    } else {
      categories = Income.instance.income;
      // className = Income;
    }
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      value = args["value"];
      comment = args["comment"];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double cellWidth = (constraints.maxWidth - 32) / 3;
          return SingleChildScrollView(
              child: Table(
            border: TableBorder.all(
              color: const Color(0xfffef7ff),
              width: 3,
            ),
            children: _buildTableRows(categories, cellWidth),
          ));
        },
      ),

      // Table(
      //   children: _buildTableRows(expenses),
      // )
    );
  }

  List<TableRow> _buildTableRows(List<Category> items, double cellWidth) {
    List<TableRow> rows = [];
    for (int i = 0; i < items.length; i += 3) {
      rows.add(
        TableRow(
          children: [
            _buildCell(items[i].name, cellWidth),
            if (i + 1 < items.length)
              _buildCell(items[i + 1].name, cellWidth)
            else
              Container(),
            if (i + 2 < items.length)
              _buildCell(items[i + 2].name, cellWidth)
            else
              Container(),
          ],
        ),
      );
    }
    return rows;
  }

  Widget _buildCell(String cellContent, double cellWidth) {
    return GestureDetector(
      onTap: () => _onCellTapped(cellContent),
      child: Container(
        height: cellWidth,
        color: Colors.lightBlueAccent,
        child: Center(
          child: Text(
            cellContent,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _onCellTapped(String cellContent) {
    // Category addCategory = Category('Add category', 0);
    // expenses.remove(addCategory);
    //expenses.removeLast();
    if (cellContent == 'Add category') {
      Map<String, dynamic> args = {
        'value': value,
        'comment': comment,
      };
      Navigator.of(context).pushNamed('${ModalRoute.of(context)!.settings.name}/add_category',
          arguments: args);
    } else {
      if (ModalRoute.of(context)!.settings.name == '/add_expenses/category') {
        Expenses.instance.addValueByName(cellContent, value);
        history.add(Transaction(cellContent, 'expenses', value, DateTime.now(), comment));
      } else {
        Income.instance.addValueByName(cellContent, value);
        history.add(Transaction(cellContent, 'income', value, DateTime.now(), comment));
      }
      Navigator.of(context).pushNamed('/');
    }
  }
}
