import 'package:flutter/material.dart';
import 'package:overwatched/components/edit_episode.dart';
import 'package:overwatched/models/episode.dart';
import 'package:overwatched/repositories/episode_repository.dart';
import 'dart:io';

class EpisodeList extends StatefulWidget {
  const EpisodeList({Key? key, required this.seasonId}) : super(key: key);

  final String seasonId;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

// This is the type used by the popup menu below.
enum Action { edit, delete }

class _EpisodeListState extends State<EpisodeList> {

  final episodeRepository = EpisodeRepository();
  late Future<List<Episode>> episodes;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    setState(() {
      episodes = episodeRepository.list(widget.seasonId);
    });
  }

  void _onToggleWatched(BuildContext context, Episode episode) async {
    try {
      await episodeRepository.toggleWatched(episode, episode.watched);
      refresh();
      showSnackbar(context, 'Episódio atualizado com sucesso.');
    } catch (err) {
      String message = 'Um erro ocorreu ao atualizar o episódio.';
      if (err is HttpException) {
        message += ' (${err.message})';
      }
      message += '. Tente novamente.';
      showSnackbar(context, message);
    }
  }

  void _onAddEpisode(BuildContext context) async {
    showDialog(context: context, builder: (BuildContext context) =>
        EditEpisodeDialog(seasonId: widget.seasonId)).whenComplete(() => refresh());
  }

  void _onEditEpisode(BuildContext context, Episode episode) async {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
          EditEpisodeDialog(
            episode: episode,
            seasonId: widget.seasonId
          )
    ).whenComplete(() => refresh());
  }

  void _onDeleteEpisode(BuildContext context, Episode episode) async {
    try {
      await episodeRepository.delete(episode);
      refresh();
      showSnackbar(context, 'Episódio apagado com sucesso.');
    } catch (err) {
      String message = 'Um erro ocorreu ao apagar o episódio.';
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
    return FutureBuilder<List<Episode>>(
      future: episodes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final episode = snapshot.data![index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        episode.number.toString(),
                        style: Theme.of(context).textTheme.bodyLarge
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: ColoredBox(
                            color: Colors.grey,
                            child: SizedBox(
                              width: 2,
                              height: 20,
                            )
                        ),
                      ),
                      Text(
                        episode.name,
                        style: Theme.of(context).textTheme.bodyMedium
                      ),
                      if (episode.duration > 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                              '${episode.duration.toString()}min',
                              style: const TextStyle(
                                color: Colors.grey
                              )
                          ),
                        ),
                      Flexible(child: Container()),
                      IconButton(
                        icon: const Icon(Icons.visibility_outlined),
                        onPressed: () => _onToggleWatched(context, episode),
                        color: episode.watched ? Colors.orange : Colors.grey,
                      ),
                      PopupMenuButton<Action>(
                        // Callback that sets the selected popup menu item.
                        onSelected: (Action action) {
                          if (action == Action.edit) _onEditEpisode(context, episode);
                          if (action == Action.delete) _onDeleteEpisode(context, episode);
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<Action>>[
                          const PopupMenuItem<Action>(
                            value: Action.edit,
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem<Action>(
                            value: Action.delete,
                            child: Text('Delete'),
                          )
                        ]
                      ),
                    ],
                  );
                }
              ),
              TextButton(
                child: const Text(
                  'Adicionar Episódio',
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                onPressed: () => _onAddEpisode(context),
              )
            ]
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}


