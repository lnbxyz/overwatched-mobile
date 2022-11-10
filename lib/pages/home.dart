import 'package:flutter/material.dart';
import 'package:overwatched/models/serie.dart';
import 'package:overwatched/pages/edit_serie.dart';
import 'package:overwatched/pages/series_detail.dart';
import 'package:overwatched/repositories/serie_repository.dart';

import '../components/series_info_ROW.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final serieRepository = SerieRepository();
  List<Serie> series = [];
  bool isLoading = true;

  void _onClickAdd(BuildContext context) async {
    final Serie? updatedSerie = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EditSeriePage(),
      ),
    );

    if (updatedSerie != null) {
      refresh();
    }
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    setState(() {
      isLoading = true;
    });

    serieRepository.list().then((value) {
      setState(() {
        series = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overwatched'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onClickAdd(context),
        child: const Icon(Icons.add),
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          itemCount: series.length,
          itemBuilder: (context, index) {
            final serie = series[index];
            return GestureDetector(
              onTap: () async {
                final updatedSeries = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SeriesDetailPage(serie: serie),
                  ),
                );

                if (updatedSeries != null) {
                  refresh();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SerieCard(serie)
              ),
            );
          }
        ),
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
                        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                        child: serie.coverUrl.isNotEmpty
                          ? Image.network(
                            serie.coverUrl,
                            height: 120,
                            fit: BoxFit.cover,
                          )
                          : null
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
                        ),
                        SeriesInfoRow(
                          icon: Icons.theater_comedy_outlined,
                          text: serie.genres.join(', ')
                        ),
                        SeriesInfoRow(
                          icon: Icons.grade_outlined,
                          text: '${serie.score?.toStringAsFixed(1)}/10.0'
                        ),
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
