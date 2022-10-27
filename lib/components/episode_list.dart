import 'package:flutter/material.dart';
import 'package:overwatched/models/episode.dart';
import 'package:overwatched/models/season.dart';

Future<List<Episode>> fetchEpisodes() async {
  // TODO https://codewithflutter.com/flutter-fetch-data-from-api-rest-api-example/
  return Future.delayed(const Duration(seconds: 1), () => [
    Episode(
      name: 'Episode 1',
      id: '2000',
      number: 1,
      duration: 23
    ),
    Episode(
      name: 'Episode 2',
      id: '2001',
      number: 2,
      duration: 27,
      watched: true
    )
  ]);
}

class EpisodeList extends StatefulWidget {
  const EpisodeList({Key? key, required this.seasonId}) : super(key: key);

  final String seasonId;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

// This is the type used by the popup menu below.
enum Action { edit, delete }

class _EpisodeListState extends State<EpisodeList> {

  late Future<List<Episode>> episodes;

  @override
  void initState() {
    super.initState();
    episodes = fetchEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Episode>>(
      future: episodes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  snapshot.data![index].number.toString(),
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
                  snapshot.data![index].name,
                  style: Theme.of(context).textTheme.bodyMedium
                ),
                if (snapshot.data![index].duration > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                        '${snapshot.data![index].duration.toString()}min',
                        style: const TextStyle(
                          color: Colors.grey
                        )
                    ),
                  ),
                Flexible(child: Container()),
                IconButton(
                  icon: const Icon(Icons.visibility_outlined),
                  onPressed: () {
                    // Respond to button press
                  },
                  color: snapshot.data![index].watched ? Colors.orange : Colors.grey,
                ),
                PopupMenuButton<Action>(
                  // Callback that sets the selected popup menu item.
                    onSelected: (Action action) {
                      // TODO
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
                    ]),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
