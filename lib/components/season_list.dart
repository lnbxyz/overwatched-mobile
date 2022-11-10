import 'dart:io';

import 'package:flutter/material.dart';
import 'package:overwatched/components/episode_list.dart';
import 'package:overwatched/models/season.dart';
import 'package:overwatched/repositories/season_repository.dart';

import '../models/serie.dart';
import '../pages/edit_season.dart';

class SeasonList extends StatefulWidget {
  const SeasonList({Key? key, required this.serie}) : super(key: key);

  final Serie serie;

  @override
  State<SeasonList> createState() => _SeasonListState();
}

class _SeasonListState extends State<SeasonList> {

  final SeasonRepository seasonRepository = SeasonRepository();
  late Future<List<Season>> seasons;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    setState(() {
      seasons = seasonRepository.listBySerie(widget.serie.id);
    });
  }

  void _onClickAdd() {
    showDialog(context: context, builder: (BuildContext context) =>
        EditSeasonPage(serie: widget.serie)).whenComplete(() => refresh());
  }

  void _edit(Season season) {
    showDialog(context: context, builder: (BuildContext context) =>
        EditSeasonPage(serie: widget.serie, season: season)).whenComplete(() => refresh());
  }

  void _delete(Season season) async {
    try {
      seasonRepository.delete(season).then((value) => refresh());
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Season>>(
      future: seasons,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Row(
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar temporada'),
                    onPressed: () => _onClickAdd(),
                  )
                ],
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          snapshot.data![index].name,
                          style: Theme.of(context).textTheme.headline6
                        ),
                        Flexible(child: Container()),
                        IconButton(
                          icon: const Icon(Icons.delete_outlined),
                          onPressed: () => _delete(snapshot.data![index])
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () => _edit(snapshot.data![index]),
                        ),
                      ],
                    ),
                    EpisodeList(seasonId: snapshot.data![index].id)
                  ],
                )
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
