import 'dart:convert';

import 'package:asm/app/constant/app_constant.dart';
import 'package:flutter/material.dart';
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

  static Future<userModel> loginPost({
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

    print("token " + map.toString());
    print("token " + Uri.parse(API + "users/login").toString());

    var request =
        new http.MultipartRequest("POST", Uri.parse(API + 'users/login'));

    request.headers.addAll(headers);

    request.fields['email'] = email;
    request.fields['password'] = password;

    http.Response response =
        await http.Response.fromStream(await request.send());

    final message = json.decode(response.body);
    if (response.statusCode == 200) {
      print("token berhasil: " + message.toString());
    } else {
      print("token gagal: " + message.toString());
    }

    return model;
    // await http
    //     .post(
    //   Uri.parse(API + "users/login"),
    //   body: map,
    // )
    //     .then((data) {
    //   final message = json.decode(data.body);

    //   print("token: berhasil " + message);
    // }).catchError(
    //   (e) {
    //     print("token: error " + e.toString());
    //   },
    // );

    // print('token ' + response.toString());
    // print('token ' + response.statusCode.toString());
    // if (response.statusCode == 200) {
    //   var jsonData = json.decode(response.body)['data'];

    //   return userModel.fromJson(jsonData);
    // }
  }
}
