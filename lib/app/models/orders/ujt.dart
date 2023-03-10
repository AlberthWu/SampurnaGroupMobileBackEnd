import 'dart:convert';

import 'package:asm/app/constant/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ujtGetModel {
  final int id;
  final int ujt;
  final int ritase;

  ujtGetModel({
    this.id = 0,
    this.ujt = 0,
    this.ritase = 0,
  });

  factory ujtGetModel.fromJson(Map<String, dynamic> item) {
    return ujtGetModel(
      id: item['id'],
      ujt: item['ujt'],
      ritase: item['ritase'],
    );
  }

  static Future<ujtGetModel> getAPIUjt(String issueDate, String plantID,
      String originID, String fleetTypeID, String productID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString('token');

    const API = sgBaseURL;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token.toString(),
    };

    final ujtGetModel model = new ujtGetModel();

    final response = await http.get(
        Uri.parse(API +
            'ujt/get?issue_date=$issueDate&plant_id=$plantID&origin_id=$originID&fleet_type_id=$fleetTypeID&product_id=$productID'),
        headers: headers);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];

      return ujtGetModel.fromJson(jsonData);
    }

    return model;
  }
}
