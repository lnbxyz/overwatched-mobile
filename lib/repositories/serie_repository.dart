import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:overwatched/data/constants.dart';
import 'package:overwatched/models/serie.dart';
import 'package:overwatched/network/auth_interceptor.dart';

class SerieRepository {

  Client client = InterceptedClient.build(interceptors: [
    AuthInterceptor()
  ]);

  Future<Serie?> create(Serie serie) async {
    return null;
  }

  Future<List<Serie>> list() async {
    const String url = "$API_BASE_URL/series";

    Response res = await client.get(Uri.parse(url));

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