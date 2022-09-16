import 'package:flutter/material.dart';

import '../models/serie.dart';

class SeriesDetailPage extends StatefulWidget {
  const SeriesDetailPage({Key? key, required this.serie}) : super(key: key);

  final Serie serie;

  @override
  State<SeriesDetailPage> createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.serie.name),
        ),
        body: Center(
          child: Text(widget.serie.name),
        )
    );
  }
}
