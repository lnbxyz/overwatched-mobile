import 'dart:convert';
import 'dart:io';

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
    const String url = "$API_BASE_URL/series";

    String body = jsonEncode(serie, toEncodable: (value) => value is Serie
      ? Serie.toJson(serie)
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
      return Serie.fromJson(jsonDecode(res.body));
    } else {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }

  }

  Future<List<Serie>> list() async {
    const String url = "$API_BASE_URL/series";

    Response res = await client.get(Uri.parse(url));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      return body
        .map((dynamic json) => Serie.fromJson(json))
        .toList();
    } else {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }
  }

  Future<Serie?> getOne() async {
    return null;
}

  Future<Serie?> update(Serie serie) async {
    return null;
  }

  Future<void> delete(Serie? serie) async {
    String url = "$API_BASE_URL/series/${serie?.id}";

    Response res = await client.delete(Uri.parse(url));

    if (res.statusCode != 200) {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }
  }
}
