import 'dart:convert';

import 'package:asm/app/constant/app_constant.dart';
import 'package:asm/app/models/orders/schedule/order.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class scheduleListModel {
  final int id;
  final String bisnis_unit;
  final String schedule_no;
  final String schedule_date;
  final String origin_name;
  final String plant_name;
  final String fleet_type_name;
  final String product_name;
  final String urgent_name;
  final int urgent;
  final int total_do;
  final int actual;
  final int balance;
  final List<orderListModel>? orders;

  scheduleListModel({
    this.id = 0,
    this.bisnis_unit = "",
    this.schedule_no = "",
    this.schedule_date = "",
    this.origin_name = "",
    this.plant_name = "",
    this.fleet_type_name = "",
    this.product_name = "",
    this.urgent_name = "",
    this.total_do = 0,
    this.urgent = 0,
    this.actual = 0,
    this.balance = 0,
    this.orders,
  });

  factory scheduleListModel.fromJson(Map<String, dynamic> item) {
    var urgent = item['urgent'] == 1 ? "Urgent" : "Reguler";
    var order_lists = item['order_lists'];

    List<orderListModel> _orders = [];
    if (order_lists != null) {
      order_lists.forEach((v) {
        _orders.add(orderListModel.fromJson(v));
      });
    }

    return scheduleListModel(
      id: item['id'],
      bisnis_unit: item['sales_type_id']['name'],
      schedule_no: item['schedule_no'],
      schedule_date: item['issue_date'],
      origin_name: item['origin_id']['name'],
      plant_name: item['plant_id']['full_name'],
      fleet_type_name: item['fleet_type_id']['name'],
      product_name: item['product_id']['name'],
      total_do: item['total_do'],
      urgent: item['urgent'],
      urgent_name: urgent,
      actual: item['actual'] < 0 ? item['actual'] * -1 : item['actual'],
      balance: item['balance'],
      orders: _orders,
    );
  }

  static Future<List<scheduleListModel>> connectToAPI(
      String date, int page, int limit) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString('token');

    const API = sgBaseURL;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token.toString(),
    };

    final response = await http.get(
        Uri.parse(
            API + 'order/schedule?issue_date=$date&page=$page&pagesize=$limit'),
        headers: headers);

    final models = <scheduleListModel>[];

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data']['list'] as List;
      for (var item in jsonData) {
        models.add(scheduleListModel.fromJson(item));
      }

      return models.toList();
    }

    return models;
  }
}
