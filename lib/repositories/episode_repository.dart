import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:overwatched/data/constants.dart';
import 'package:overwatched/models/episode.dart';
import 'package:overwatched/models/season.dart';
import 'package:overwatched/network/auth_interceptor.dart';

class EpisodeRepository {

  Client client = InterceptedClient.build(interceptors: [
    AuthInterceptor()
  ]);

  Future<Episode?> create(Episode episode) async {
    const String url = "$API_BASE_URL/episodes";

    String body = jsonEncode(episode, toEncodable: (value) => value is Episode
      ? Episode.toJson(episode)
      : throw UnsupportedError('Cannot convert to JSON: $value')
    );

    Response res = await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body
    );

    if (res.statusCode == 201) {
      return Episode.fromJson(jsonDecode(res.body));
    } else {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }
  }

  Future<List<Episode>> list(Season season) async {
    final String url = "$API_BASE_URL/episodes?season=${season.id}";

    Response res = await client.get(Uri.parse(url));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      return body
        .map((dynamic json) => Episode.fromJson(json))
        .toList();
    } else {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }
  }

  Future<Episode?> update(Episode episode) async {
    final String url = "$API_BASE_URL/episodes/${episode.id}";

    String body = jsonEncode(episode, toEncodable: (value) => value is Episode
        ? Episode.toJson(episode)
        : throw UnsupportedError('Cannot convert to JSON: $value')
    );

    Response res = await client.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body
    );

    if (res.statusCode == 200) {
      return Episode.fromJson(jsonDecode(res.body));
    } else {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }
  }

  Future<void> delete(Episode episode) async {
    final String url = "$API_BASE_URL/episodes/${episode.id}";

    Response res = await client.delete(Uri.parse(url));

    if (res.statusCode != 200) {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }
  }
  
  Future<void> toggleWatched(Episode episode, bool isWatched) async {
    final String url = "$API_BASE_URL/episodes/${episode.id}/${isWatched ? 'watched' : 'remove-watched'}";

    Response res = await client.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    if (res.statusCode != 200) {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }
  }
}
