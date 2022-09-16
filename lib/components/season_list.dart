import 'package:flutter/material.dart';
import 'package:overwatched/models/season.dart';

Future<List<Season>> fetchSeasons() async {
  // TODO https://codewithflutter.com/flutter-fetch-data-from-api-rest-api-example/
  return Future.delayed(const Duration(seconds: 1), () => [
    Season(
      name: 'Season 1',
      id: '1000',
      number: 1,
    )
  ]);
}

class SeasonList extends StatefulWidget {
  const SeasonList({Key? key, required this.serieId}) : super(key: key);

  final String serieId;

  @override
  State<SeasonList> createState() => _SeasonListState();
}

class _SeasonListState extends State<SeasonList> {

  late Future<List<Season>> seasons;

  @override
  void initState() {
    super.initState();
    seasons = fetchSeasons();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Season>>(
      future: seasons,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
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
                      onPressed: () {
                        // Respond to button press
                      }
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {
                        // Respond to button press
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.post_add_outlined),
                      onPressed: () {
                        // Respond to button press
                      },
                    )
                  ],
                )
              ],
            )
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
