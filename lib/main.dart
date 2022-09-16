import 'package:flutter/material.dart';
import 'package:overwatched/pages/series_detail.dart';

import 'models/serie.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SeriesDetailPage(serie: Serie(
        id: '123',
        name: 'Superstore',
        coverUrl: 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmedia.senscritique.com%2Fmedia%2F000012652227%2Fsource_big%2FSuperstore.jpg&f=1&nofb=1',
        description: 'A look at the lives of employees at a big box store.',
        releaseYear: '2015',
        endingYear: '2021',
        genres: ['Sitcom', 'Workplace', 'Comedy'],
        score: 7.8
      )),
    );
  }
}
