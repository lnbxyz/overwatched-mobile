class LoginResponse {
  String access_token;

  LoginResponse({
    this.access_token = ''
  });

  LoginResponse.fromJson(Map<String, dynamic> json)
      : access_token = json['access_token'];

  static Map<String, dynamic> toJson(LoginResponse value) =>
      {'access_token': value.access_token};
}