import 'dart:convert';

import 'package:asm/app/constant/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class employeeListModel {
  final int id;
  final String nik;
  final String name;
  final String alias;
  final String companyName;

  employeeListModel({
    this.id = 0,
    this.nik = "",
    this.name = "",
    this.alias = "",
    this.companyName = "",
  });

  factory employeeListModel.fromJson(Map<String, dynamic> item) {
    return employeeListModel(
      id: item['id'],
      nik: item['nik'],
      name: item['name'],
      alias: item['alias'],
      companyName: item['company_id']['code'],
    );
  }

  static Future<List<employeeListModel>> connectToAPI(
      int page, int limit, String keyword) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString('token');

    const API = sgBaseURL;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token.toString(),
    };

    final response = await http.get(
        Uri.parse(API + 'employee?page=$page&pagesize=$limit&keyword=$keyword'),
        headers: headers);

    final models = <employeeListModel>[];

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data']['list'] as List;
      for (var item in jsonData) {
        models.add(employeeListModel.fromJson(item));
      }

      return models.toList();
    }

    return models;
  }
}
