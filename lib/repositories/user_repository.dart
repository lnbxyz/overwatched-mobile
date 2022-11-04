import 'package:http/http.dart';
import 'package:overwatched/models/login_request.dart';
import 'package:overwatched/models/login_response.dart';

class UserRepository {
  Future<Object?> register(LoginRequest user) async {
    const String url = "http://10.0.2.2:3000/users";

    Response res = await post(Uri.parse(url), body: user);

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