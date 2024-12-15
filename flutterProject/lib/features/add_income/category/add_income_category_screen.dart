import 'dart:math';

import 'package:finflow/fin_flow_app.dart';
import 'package:flutter/material.dart';

class AddIncomeCategory extends StatefulWidget {
  const AddIncomeCategory({super.key, required this.title});

  final String title;

  @override
  State<AddIncomeCategory> createState() => _AddIncomeCategoryState();
}

class _AddIncomeCategoryState extends State<AddIncomeCategory> {
  List<Category> income = Income.instance.income;
  final Category addCategory = Category('Add category', 0);

  late double incomeValue;

  @override
  void initState() {
    super.initState();
    income.remove(addCategory);
    income.add(addCategory);
  }

  @override
  void dispose() {
    income.remove(addCategory);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is double) {
      incomeValue = args;
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
            children: _buildTableRows(income, cellWidth),
          ));
        },
      ),

      // Table(
      //   children: _buildTableRows(income),
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
    // income.remove(addCategory);
    //income.removeLast();
    if (cellContent == 'Add category') {
      Navigator.of(context).pushNamed('/add_income/category/add_category',
          arguments: incomeValue);
    } else {
      Income.instance.addValueByName(cellContent, incomeValue);
      Navigator.of(context).pushNamed('/');
    }
  }
}