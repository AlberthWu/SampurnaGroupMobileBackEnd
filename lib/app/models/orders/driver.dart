import 'dart:convert';

import 'package:asm/app/constant/app_constant.dart';
import 'package:asm/app/models/employee/get.dart';
import 'package:http/http.dart' as http;

class driverGetModel {
  final employeeGetModel? primary_driver;
  final employeeGetModel? secondary_driver;

  driverGetModel({
    this.primary_driver,
    this.secondary_driver,
  });

  factory driverGetModel.fromJson(Map<String, dynamic> item) {
    var _employeePrimary;
    var primary = item['primary_driver'];

    if (primary != null) {
      _employeePrimary = employeeGetModel.fromJson(primary);
    } else {
      _employeePrimary = new employeeGetModel();
    }

    var _employeeSecondary;
    var secondary = item['secondary_driver'];

    if (secondary != null) {
      _employeeSecondary = employeeGetModel.fromJson(secondary);
    } else {
      _employeeSecondary = new employeeGetModel();
    }

    return driverGetModel(
      primary_driver: _employeePrimary,
      secondary_driver: _employeeSecondary,
    );
  }

  static Future<driverGetModel> getAPIDriver(
      String issueDate, String plateNo) async {
    const API = sgBaseURL;
    const headers = {
      'Content-Type': 'application/json',
    };

    final driverGetModel model = new driverGetModel();

    final response = await http.get(
        Uri.parse(API +
            'fleetformation/driver?issue_date=$issueDate&plate_no=$plateNo'),
        headers: headers);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];

      return driverGetModel.fromJson(jsonData);
    }

    return model;
  }
}
