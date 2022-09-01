import 'package:flutter/material.dart';

class SeriesDetailPage extends StatefulWidget {
  const SeriesDetailPage({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<SeriesDetailPage> createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Center(
          child: Text(widget.name),
        )
    );
  }
}
