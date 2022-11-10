import 'dart:io';

import 'package:flutter/material.dart';
import 'package:overwatched/components/season_list.dart';
import 'package:overwatched/components/series_info_ROW.dart';
import 'package:overwatched/models/serie.dart';
import 'package:overwatched/pages/edit_season.dart';
import 'package:overwatched/repositories/serie_repository.dart';

import 'edit_serie.dart';

class SeriesDetailPage extends StatefulWidget {
  const SeriesDetailPage({Key? key, required this.serie}) : super(key: key);

  final Serie serie;

  @override
  State<SeriesDetailPage> createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  final serieRepository = SerieRepository();
  late Serie serie;
  bool hasUpdated = false;

  _onClickEdit(BuildContext context) async {
    final Serie? updatedSerie = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditSeriePage(serie: serie),
      ),
    );

    if (updatedSerie != null) {
      setState(() {
        serie = updatedSerie;
        hasUpdated = true;
      });
    }
  }

  @override
  void initState() {
    serie = widget.serie;
    super.initState();
  }

  void _onClickDelete(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext alertContext) => AlertDialog(
          title: const Text('Tem certeza de que deseja apagar a série?'),
          actions: <Widget>[
            TextButton(
              child: const Text("Voltar"),
              onPressed: () {
                Navigator.of(alertContext, rootNavigator: true).pop();
              },
            ),
            TextButton(
              child: const Text("Sim"),
              onPressed: () {
                _delete(context);
                Navigator.of(alertContext, rootNavigator: true).pop();
              },
            ),
          ],
        )
    );
  }

  void _delete(BuildContext context) async {
    try {
      serieRepository.delete(serie).then((value) => Navigator.of(context).pop(serie));
    } catch (err) {
      String message = 'Um erro ocorreu ao apagar a série';
      if (err is HttpException) {
        message += ' (${err.message})';
      }
      message += '. Tente novamente.';
      showSnackbar(context, message);
    }
  }

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text))
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(hasUpdated ? serie : null);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(serie.name),
          actions: [
            IconButton(
              onPressed: () => _onClickDelete(context),
              icon: const Icon(Icons.delete)
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  ShaderMask(
                      blendMode: BlendMode.srcATop,
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                            colors: [
                              Color.fromARGB(0, 250, 250, 250),
                              Color.fromARGB(255, 250, 250, 250)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.5, 0.9]).createShader(bounds);
                      },
                      child: serie.coverUrl.isNotEmpty
                          ? Image.network(serie.coverUrl)
                          : null),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(serie.name,
                          style: Theme.of(context).textTheme.headline2)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SeriesInfoRow(
                        icon: Icons.calendar_today_outlined,
                        text:
                            '${serie.releaseYear} - ${(serie.endingYear.isNotEmpty) ? serie.endingYear : 'Presente'}'),
                    const SizedBox(height: 8),
                    SeriesInfoRow(
                        icon: Icons.theater_comedy_outlined,
                        text: serie.genres.join(', ')),
                    const SizedBox(height: 8),
                    SeriesInfoRow(
                        icon: Icons.grade_outlined,
                        text: '${serie.score?.toStringAsFixed(1)}/10.0'),
                    const SizedBox(height: 16),
                    Text(serie.description,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        OutlinedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Adicionar temporada'),
                          onPressed: () {
                            showDialog(context: context, builder: (BuildContext context) => EditSeasonPage(serie: serie));
                          },
                        )
                      ],
                    ),
                    SeasonList(serieId: serie.id),
                    const SizedBox(height: 200),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onClickEdit(context),
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
