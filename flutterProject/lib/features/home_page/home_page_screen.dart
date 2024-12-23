import 'package:finflow/features/local_storage/save_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../fin_flow_app.dart';
import '../history/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> expenses = Expenses.instance.expenses;
  List<Category> income = Income.instance.income;
  List<Transaction> history = History.instance.history;
  late List<Category> categories;
  List<CategoryNew> categoriesNew = [];

  String lastCategory = '';
  double lastAmount = 0;
  DateTime lastDateTime = DateTime(0); //DateTime.now();
  String lastComment = '';

  @override
  void initState() {
    super.initState();
    if (history.isNotEmpty) {
      final lastTransaction = history.last;
      lastCategory = lastTransaction.categoryName;
      lastAmount = lastTransaction.amount;
      lastDateTime = lastTransaction.transactionDate;
      lastComment = lastTransaction.description;
    } else {
      lastCategory = 'No Category';
      lastAmount = 0;
      lastDateTime = DateTime.now();
      lastComment = 'No Comment';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.sync),
          onPressed: () async {
            List<CategoryNew> categoriesNew = mergeCategories(expenses, income);
            final lastChangeDate = DateTime.now();
            await sendPatchRequest(
              context: context,
              lastChangeDate: lastChangeDate,
              addedCategories: categoriesNew,
              addedTransactions: history,
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/authorization');
            },
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              children: [
                SingleChildScrollView(
                  child: Column(children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          sections: getSections(Expenses.instance.expenses),
                          centerSpaceRadius: 50,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/delete_category_expenses');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.delete),
                          SizedBox(width: 8),
                          Text('Delete category'),
                        ],
                      ),
                    ),
                  ]),
                ),
                SingleChildScrollView(
                  child: Column(children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          sections: getSections(Income.instance.income),
                          centerSpaceRadius: 50,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/delete_category_income');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.delete),
                          SizedBox(width: 8),
                          Text('Delete category'),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/add_expenses');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  fixedSize: const Size(150, 75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Expense',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/add_income');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  fixedSize: const Size(150, 75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Income',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/history');
            },
            child: LastTransactionDetails(
              category: lastCategory,
              amount: lastAmount,
              dateTime: lastDateTime,
              comment: lastComment,
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> getSections(List<Category> categories) {
    List<PieChartSectionData> sectionData = [];
    List<Color> colors = [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.lightBlueAccent,
      Colors.pinkAccent,
      Colors.deepOrangeAccent,
    ];
    double sumExpenses = 0;
    for (var i = 0; i < categories.length; i++) {
      print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"+categories[i].name);
      sumExpenses += categories[i].value;
    }
    for (var i = 0; i < categories.length; i++) {
      print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"+categories[i].name);
      sectionData.add(PieChartSectionData(
        color: colors[i % colors.length],
        value: categories[i].value,
        title: '''${categories[i].name}
${((categories[i].value / sumExpenses) * 100).round()}%''',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 14, // уменьшенный размер шрифта
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      ));
    }
    if (sectionData.isEmpty) {
      sectionData.add(PieChartSectionData(
        color: Colors.grey,
        value: 10,
        title: '''Add smth''',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 14, // уменьшенный размер шрифта
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      ));
    }
    return sectionData;
  }
}
