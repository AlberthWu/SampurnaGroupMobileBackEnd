import 'dart:convert';

import 'package:asm/app/models/auth/user.dart';
import 'package:http/http.dart' as http;

abstract class UserService {
  static userModel? getUser({required String email, required String token}) {
    return userModel(
        name: "Firman", email: "fsetiawan8@yahoo.com", token: token);
  }

  static Future<String?> getToken(
      {required String email, required String password}) async {
    final headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    String jsonBody = json.encode(body);

    final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/login"),
        headers: headers,
        body: jsonBody);

    if (response.statusCode == 200) {
      String responseBody = response.body;

      return responseBody;
    }

    return null;
  }

  static bool isTokenValid(String token) {
    return true;
  }
}
