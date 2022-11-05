import 'dart:convert';

import 'package:http/http.dart';
import 'package:overwatched/models/login_request.dart';
import 'package:overwatched/models/login_response.dart';

class UserRepository {
  Future<Object?> register(LoginRequest user) async {
    const String url = "http://localhost:3000/users";

    String userJson = jsonEncode( user, toEncodable: (Object? value) => value is LoginRequest
        ? LoginRequest.toJson(value)
        : throw UnsupportedError('Cannot convert to JSON: $value'));
    Response res = await post(Uri.parse(url), body: userJson);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw "Error registering";
    }
  }

  Future<LoginResponse?> login(LoginRequest user) async {
    return null;
  }
}