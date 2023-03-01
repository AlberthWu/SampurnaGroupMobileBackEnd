import 'dart:convert';
import 'package:asm/app/controllers/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url =
          Uri.parse('http://restapi.adequateshop.com/api/authaccount/login');

      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text,
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 0) {
          var token = json['data']['Token'];
          print(token);
          final SharedPreferences? prefs = await _prefs;

          await prefs?.setString("token", token);
          emailController.clear();
          passwordController.clear();
          Get.off(DashboardPage());
        } else {
          throw jsonDecode(response.body)['message'] ?? "Unknown error occured";
        }
      } else {
        throw jsonDecode(response.body)['Message'] ?? "Unknown error occured";
      }
    } catch (e) {
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [
              Text(
                e.toString(),
              ),
            ],
          );
        },
      );
    }
  }
}
