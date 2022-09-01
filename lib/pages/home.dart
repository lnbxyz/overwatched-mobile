import 'package:flutter/material.dart';
import 'package:overwatched/pages/series_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _data = [];

  void _fetchData() {
    setState(() {
      _data = [
        'test',
        'test 2'
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
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              key: ValueKey(_data[index]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_data[index]),
              ),
            ),
            // onTap: () {
            //   Navigator.of(context).push(
            //     MaterialPageRoute(
            //       builder: (context) => SeriesDetailPage(name: _data[index]),
            //     ),
            //   );
            // },
          );
        }
      )
    );
  }
}
