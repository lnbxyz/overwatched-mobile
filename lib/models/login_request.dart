class LoginRequest {
  String username;
  String password;

  LoginRequest({
    this.username = '',
    this.password = '',
  });

  LoginRequest.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  static Map<String, dynamic> toJson(LoginRequest value) =>
      {'username': value.username, 'password': value.password};
}