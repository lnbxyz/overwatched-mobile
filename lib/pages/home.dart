import 'package:flutter/material.dart';
import 'package:overwatched/models/serie.dart';
import 'package:overwatched/pages/series_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Serie> _data = [];

  void _fetchData() {
    setState(() {
      _data = [
        Serie(
          id: "1",
          name: 'Russian Doll',
          coverUrl: "https://www.tvguide.com/a/img/catalog/provider/1/1/1-7650473727.jpg",
          description: "Russian Doll is a 30 minute comedy-fantasy-mystery-science fiction starring Natasha Lyonne as Nadia Vulvokov, Charlie Barnett as Alan Zaveri and Greta Lee as Maxine.",
          releaseYear: "2019",
          endingYear: "Present",
          genres: ["Fantasy", "Comedy"],
          score: 7.8
        )
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    _fetchData();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Overwatched'),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SerieCard(_data[index])
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SeriesDetailPage(serie: _data[index]),
                        ),
                      );
                    },
                  );
                })
        )
    );
  }
}

class SerieCard extends StatelessWidget {
  const SerieCard(this.serie, {super.key});

  final Serie serie;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(serie.id),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(serie.name),
      ),
    );
  }

}
