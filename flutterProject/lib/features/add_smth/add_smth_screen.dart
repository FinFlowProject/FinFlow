import 'package:flutter/material.dart';

class AddSmth extends StatefulWidget {
  const AddSmth({super.key, required this.title});

  final String title;

  @override
  State<AddSmth> createState() => _AddSmthState();
}

class _AddSmthState extends State<AddSmth> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)!.settings.name;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        TextField(
          controller: _numberController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Enter a number',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _commentController,
          decoration: const InputDecoration(
            hintText: 'Add comment',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
            onPressed: () {
              double? value = double.tryParse(_numberController.text);
              String comment = _commentController.text;
              if (value != null && value > 0) {
                Map<String, dynamic> args = {
                  'value': value,
                  'comment': comment,
                };
                if (routeName == '/add_expenses') {
                  Navigator.of(context).pushNamed('/add_expenses/category', arguments: args);
                }
                if (routeName == '/add_income') {
                  Navigator.of(context).pushNamed('/add_income/category', arguments: args);
                }
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text("Add valid number"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Choose category')),
      ]),
    );
  }
}
