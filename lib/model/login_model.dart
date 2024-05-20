import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String username;
  final String password;
  final String? token;

  LoginModel(
      {
    required this.username,
        this.token,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    username: json["username"],
    password: json["password"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "token": token,
  };
}
