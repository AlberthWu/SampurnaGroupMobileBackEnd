import 'dart:convert';

import 'package:asm/app/constant/app_constant.dart';
import 'package:http/http.dart' as http;

class autocompleteListModel {
  final int id;
  final String name;

  autocompleteListModel({
    this.id = 0,
    this.name = "",
  });

  factory autocompleteListModel.fromJson(
      Map<String, dynamic> item, String name) {
    return autocompleteListModel(
      id: item['id'],
      name: item[name],
    );
  }

  String showAsString() {
    return '${this.name}';
  }

  String getIDString() {
    return this.id.toString();
  }

  int getID() {
    return this.id;
  }

  String getName() {
    return this.name;
  }

  static Future<List<autocompleteListModel>> getAPIFleetAutoComplete(
      String business_id, String fleet_type_id, String keyword) async {
    const API = sgBaseURL;
    const headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(
        Uri.parse(API +
            'fleet/list/$business_id?fleet_type_id=$fleet_type_id&keyword=$keyword'),
        headers: headers);

    final List<autocompleteListModel> models = [];

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'] as List;

      if (jsonData == null) {
        return models;
      }

      for (var item in jsonData) {
        models.add(autocompleteListModel.fromJson(item, 'plate_no'));
      }

      return models.toList();
    }

    return models;
  }
}
