import 'package:flutter/material.dart';
import '../../fin_flow_app.dart';

class TransactionsHistory extends StatelessWidget {
  // final List<Transaction> history;
  final String title;

  const TransactionsHistory({Key? key, required this.title}) : super(key: key);

  String formatDateTime(DateTime dateTime) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String day = twoDigits(dateTime.day);
    String month = twoDigits(dateTime.month);
    String year = dateTime.year.toString();
    String hour = twoDigits(dateTime.hour);
    String minute = twoDigits(dateTime.minute);
    return '$day-$month-$year $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    List<Transaction> history = History.instance.history;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final transaction = history[history.length - index - 1];
          String formattedDate = formatDateTime(transaction.dateTime);
          return ListTile(
            title: Text(transaction.category),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Amount: ${transaction.amount.toStringAsFixed(2)}'),
                Text('Date: $formattedDate'),
                Text('Comment: ${transaction.comment}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
