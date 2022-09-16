import 'package:flutter/material.dart';

class SeriesInfoRow extends StatelessWidget {
  const SeriesInfoRow({Key? key, required this.icon, required this.text}) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color.fromARGB(255, 237, 101, 22),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
            ),
          ),
        )
      ],
    );
  }
}
