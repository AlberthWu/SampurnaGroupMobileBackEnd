import 'dart:convert';

import 'package:asm/app/constant/color.dart';
import 'package:http/http.dart' as http;

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
    const API = sgBaseURL;
    const headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(
        Uri.parse(API + 'employee?page=$page&pagesize=$limit&keyword=$keyword'),
        headers: headers);

    var jsonObject = json.decode(response.body)['data']['list'] as List;

    return jsonObject
        .map<employeeListModel>(
          (item) => employeeListModel(
            id: item['id'],
            nik: item['nik'],
            name: item['name'],
            alias: item['alias'],
            companyName: item['company_id']['code'],
          ),
        )
        .toList();
  }
}
