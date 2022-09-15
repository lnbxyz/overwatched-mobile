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
            coverUrl:
                "https://www.tvguide.com/a/img/catalog/provider/1/1/1-7650473727.jpg",
            description:
                "Russian Doll is a 30 minute comedy-fantasy-mystery-science fiction starring Natasha Lyonne as Nadia Vulvokov, Charlie Barnett as Alan Zaveri and Greta Lee as Maxine.",
            releaseYear: "2019",
            endingYear: "Present",
            genres: ["Fantasy", "Comedy"],
            score: 7.8),
        Serie(
            id: "2",
            name: 'Stranger Things',
            coverUrl:
                "https://br.web.img2.acsta.net/pictures/19/07/10/20/01/2331295.jpg",
            description:
                "When a young boy disappears, his mother, a police chief and his friends must confront terrifying supernatural forces in order to get him back.",
            releaseYear: "2016",
            endingYear: "Present",
            genres: ["Drama", "Fantasy", "Horror"],
            score: 8.7),
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
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: SerieCard(_data[index])),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SeriesDetailPage(serie: _data[index]),
                        ),
                      );
                    },
                  );
                })));
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
        child: SizedBox(
          width: double.infinity,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 0,
                  child: SizedBox(
                    height: 120,
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        child: Image.network(
                          serie.coverUrl,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          serie.name,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          serie.description,
                          style: Theme.of(context).textTheme.bodyText2,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
