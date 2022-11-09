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
    return null;
  }

  Future<List<Serie>> list() async {
    const String url = "$API_BASE_URL/series";

    Response res = await client.get(Uri.parse(url));

    print(res.body);
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

  Future<bool> delete(Serie serie) async {
    return true;
  }
}