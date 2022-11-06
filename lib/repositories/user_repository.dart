import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:overwatched/models/login_request.dart';
import 'package:overwatched/models/login_response.dart';

class UserRepository {
  Future<Object?> register(LoginRequest user) async {
    const String url = "http://localhost:3000/users";

    String userJson = jsonEncode( user, toEncodable: (value) => value is LoginRequest
        ? LoginRequest.toJson(value)
        : throw UnsupportedError('Cannot convert to JSON: $value'));
    print(userJson);
    Response res = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: userJson);

    print(res.body);
    if (res.statusCode == 201) {
      return res.body;
    } else {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }
  }

  Future<LoginResponse> login(LoginRequest user) async {
    const String url = "http://localhost:3000/auth/login";

    String userJson = jsonEncode( user, toEncodable: (value) => value is LoginRequest
        ? LoginRequest.toJson(value)
        : throw UnsupportedError('Cannot convert to JSON: $value'));
    print(userJson);
    Response res = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: userJson);

    print(res.body);
    if (res.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(res.body));
    } else {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }
  }
}