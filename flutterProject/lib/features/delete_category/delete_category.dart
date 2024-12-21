import 'package:finflow/fin_flow_app.dart';
import 'package:flutter/material.dart';

class DeleteCategory extends StatefulWidget {
  const DeleteCategory({super.key, required this.title});

  final String title;

  @override
  State<DeleteCategory> createState() => _DeleteCategoryState();
}

class _DeleteCategoryState extends State<DeleteCategory> with SingleTickerProviderStateMixin {
  List<Category> expenses = Expenses.instance.expenses;
  List<Category> income = Income.instance.income;
  late List<Category> categories;
  late AnimationController _controller;
  late Animation<double> _animation;
  final Category addCategory = Category('Add category', 0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -0.05, end: 0.05).animate(_controller);
    expenses.remove(addCategory);
    income.remove(addCategory);
  }

  @override
  void dispose() {
    _controller.dispose();
    expenses.remove(addCategory);
    income.remove(addCategory);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)!.settings.name;
    if (routeName == '/delete_category_expenses') {
      categories = Expenses.instance.expenses;
      // className = Expenses;
    } else {
      categories = Income.instance.income;
      // className = Income;
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
            ),
          );
        },
      ),
    );
  }

  List<TableRow> _buildTableRows(List<Category> items, double cellWidth) {
    List<TableRow> rows = [];
    for (int i = 0; i < items.length; i += 3) {
      rows.add(
        TableRow(
          children: [
            _buildAnimatedCell(items[i].name, cellWidth),
            if (i + 1 < items.length)
              _buildAnimatedCell(items[i + 1].name, cellWidth)
            else
              Container(),
            if (i + 2 < items.length)
              _buildAnimatedCell(items[i + 2].name, cellWidth)
            else
              Container(),
          ],
        ),
      );
    }
    return rows;
  }

  Widget _buildAnimatedCell(String cellContent, double cellWidth) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value,
          child: GestureDetector(
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
          ),
        );
      },
    );
  }

  void _onCellTapped(String cellContent) {
    setState(() {
      categories.removeWhere((category) => category.name == cellContent);
    });

    Navigator.of(context).pushNamed('/');
  }
}
