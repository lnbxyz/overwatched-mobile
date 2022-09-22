import 'package:flutter/material.dart';

class SimpleAlert extends StatelessWidget {
  const SimpleAlert(
      {super.key, required this.title, this.content, this.buttonText = 'OK'});

  final String title;
  final String? content;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content == null ? null : Text(content ?? ''),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, buttonText),
          child: Text(buttonText),
        ),
      ],
    );
  }
}
