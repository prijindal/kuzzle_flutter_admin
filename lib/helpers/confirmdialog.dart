import 'package:flutter/material.dart';

Future<bool> confirmDialog(
    BuildContext context, String title, String content) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        RaisedButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        RaisedButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    ),
  );
  return confirm;
}
