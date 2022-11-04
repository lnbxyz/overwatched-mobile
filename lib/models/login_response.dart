import 'package:mobx/mobx.dart';

//flutter pub run build_runner build
part 'login_response.g.dart';

class LoginResponse = _LoginResponse with _$LoginResponse;

abstract class _LoginResponse with Store {
  String access_token;

  _LoginResponse({
    this.access_token = ''
  });
}