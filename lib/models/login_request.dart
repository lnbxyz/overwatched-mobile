import 'package:mobx/mobx.dart';

//flutter pub run build_runner build
part 'login_request.g.dart';

class LoginRequest = _LoginRequest with _$LoginRequest;

abstract class _LoginRequest with Store {
  String username;
  String password;

  _LoginRequest({
    this.username = '',
    this.password = '',
  });
}