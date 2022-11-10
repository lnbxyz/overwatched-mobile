import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:overwatched/models/season.dart';

import '../data/constants.dart';
import '../network/auth_interceptor.dart';

class SeasonRepository {

  Client client = InterceptedClient.build(interceptors: [
    AuthInterceptor()
  ]);


  Future<Season> create(Season season) async {
    const String url = "$API_BASE_URL/seasons";

    String body = jsonEncode(season, toEncodable: (value) => value is Season
        ? Season.toJson(season)
        : throw UnsupportedError('Cannot convert to JSON: $value')
    );
    print(body);

    Response res = await client.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body
    );

    print(res.body);
    if (res.statusCode == 201) {
      return Season.fromJson(jsonDecode(res.body));
    } else {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }
  }

  Future<List<Season>> listBySerie(String serieId) async {
    String url = "$API_BASE_URL/seasons?series=$serieId";

    Response res = await client.get(Uri.parse(url));
    print(res.body);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      return body
          .map((dynamic json) => Season.fromJson(json))
          .toList();
    } else {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }
  }

  Future<Season?> getOne() async {
    return null;
  }

  Future<Season?> update(Season season) async {
    return null;
  }

  Future<bool> delete(Season season) async {
    return true;
  }
}