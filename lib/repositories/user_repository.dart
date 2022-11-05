import 'dart:convert';

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

    if (res.statusCode == 201) {
      return res.body;
    } else {
      throw "${res.statusCode}: ${res.body}";
    }
  }

  Future<LoginResponse?> login(LoginRequest user) async {
    return null;
  }
}