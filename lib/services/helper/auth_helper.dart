import 'dart:convert';

import 'package:flutterdummytest/model/login_model.dart';
import 'package:flutterdummytest/model/login_response_model.dart';
import 'package:flutterdummytest/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

      final url = Uri.parse(Config.loginUrl);
      final response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model),
      );
      print(response.statusCode);
      //print(response.body);
      if(response.statusCode == 200){

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        String token = loginResponseModelFromJson(response.body).token;
        int id = loginResponseModelFromJson(response.body).id;
        await prefs.setString('token', token);
        await prefs.setInt('id', id);
        print("Token : $token");
        print("id : $id");
        return true;
      } else {
        return false;
      }

  }
}
