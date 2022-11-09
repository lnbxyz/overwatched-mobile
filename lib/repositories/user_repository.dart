import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:overwatched/data/shared_preference_helper.dart';
import 'package:overwatched/models/login_request.dart';
import 'package:overwatched/models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/constants.dart';

class UserRepository {
  Future<Object?> register(LoginRequest user) async {
    const String url = "$API_BASE_URL/users";

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
    const String url = "$API_BASE_URL/auth/login";

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
      LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(res.body));

      var prefs = SharedPreferenceHelper(prefs: await SharedPreferences.getInstance());
      prefs.setUserToken(userToken: loginResponse.access_token);
      
      return loginResponse;
    } else {
      Map<String, String> map = Map.castFrom(json.decode(res.body));
      throw HttpException(map['message']!);
    }
  }
}