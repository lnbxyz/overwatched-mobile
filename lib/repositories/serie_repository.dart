import 'dart:convert';

import 'package:http/http.dart';
import 'package:overwatched/models/serie.dart';

class SerieRepository {
  Future<Serie?> create(Serie serie) async {
    return null;
  }

  Future<List<Serie>> list() async {
    const String url = "http://10.0.2.2:3000/series";

    Response res = await get(Uri.parse(url));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      return body
        .map(
          (dynamic json) => Serie(
            id: json['_id'] as String,
            name: json['name'] as String,
            description: json['description'] as String,
            score: json['score'] as double,
            genres: (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
            endingYear: json['endingYear'] != null ? json['endingYear'] as String : '',
            releaseYear: json['releaseYear'] as String,
            coverUrl: json['coverUrl'] as String,
          )
        )
        .toList();
    } else {
      throw "Error fetching series";
    }

  }

  Future<Serie?> getOne() async {
    return null;
}

  Future<Serie?> update(Serie serie) async {
    return null;
  }

  Future<bool> delete(Serie serie) async {
    return true;
  }
}