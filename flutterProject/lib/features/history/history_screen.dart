import 'package:flutter/material.dart';

class LastTransactionDetails extends StatelessWidget {
  final String category;
  final double amount;
  final DateTime dateTime;
  final String comment;

  const LastTransactionDetails({
    Key? key,
    required this.category,
    required this.amount,
    required this.dateTime,
    required this.comment,
  }) : super(key: key);


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
    String formattedDate = formatDateTime(dateTime);
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category: $category',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Amount: ${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${formattedDate}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Comment: $comment',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
