import 'dart:convert';

import 'package:asm/app/constant/app_constant.dart';
import 'package:asm/app/models/errors_model.dart';
import 'package:asm/app/models/http_response.dart';
import 'package:http/http.dart' as http;

class userModel {
  final String? name;
  final String? email;
  final String? token;
  final String? message;

  const userModel({
    this.name,
    this.email,
    this.message,
    this.token,
  });

  factory userModel.fromJson(Map<String, dynamic> item) {
    return userModel(
      name: item['name'],
      email: item['email'],
      token: item['token'],
      message: item['message'],
    );
  }

  static Future<restResponse<userModel>> loginPost({
    required String email,
    required String password,
  }) async {
    const API = sgBaseURL;
    const headers = {
      'Content-Type': 'application/json',
    };

    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;

    final userModel model = new userModel();

    var request =
        new http.MultipartRequest("POST", Uri.parse(API + 'users/login'));

    request.headers.addAll(headers);

    request.fields['email'] = email;
    request.fields['password'] = password;

    http.Response response =
        await http.Response.fromStream(await request.send());

    final message = json.decode(response.body)['errmsg'];

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'];

      return restResponse<userModel>(
        data: userModel.fromJson(jsonData),
        message: message,
      );
    } else if (response.statusCode == 400) {
      final List<errorsModel> models = [];

      final data = json.decode(response.body)['data'] as List;
      for (var item in data) {
        models.add(errorsModel.fromJson(item));
      }

      return restResponse<userModel>(
        status: true,
        data: model,
        message: message,
        errors: models,
      );
    }

    return restResponse<userModel>(
      status: true,
      data: model,
      message: message,
    );
  }
}
