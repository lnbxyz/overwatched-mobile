import 'package:flutter/material.dart';
import 'package:overwatched/models/serie.dart';

class SeriesDetailPage extends StatefulWidget {
  const SeriesDetailPage({Key? key, required this.serie}) : super(key: key);

  final Serie serie;

  @override
  State<SeriesDetailPage> createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serie.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [Color.fromARGB(0, 255, 255, 255), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.5, 0.9]
                ).createShader(bounds);
              },
              child: Image.network(widget.serie.coverUrl)
            )
          ],
        ),
      )
    );
  }
}
