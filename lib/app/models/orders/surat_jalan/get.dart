import 'dart:convert';

import 'package:asm/app/constant/app_constant.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/employee/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class deliveryGetModel {
  final int id;
  final int company_id;
  final String company_name;
  final int bisnis_id;
  final String bisnis_name;
  final String schedule_no;
  final String schedule_date;
  final String delivery_no;
  final String delivery_date;
  final int order_type_id;
  final String order_type_name;
  final int customer_id;
  final String customer_name;
  final int origin_id;
  final String origin_name;
  final int plant_id;
  final String plant_name;
  final int fleet_type_id;
  final String fleet_type_name;
  final int fleet_id;
  final String plate_no;
  final String sj_customer;
  final int multi_product;
  final int product_id;
  final String product_name;
  final int employee_id;
  final String employee_name;
  final String rekening_no;
  final String nama_rekening;
  final String image;
  final int confirm_ujt;
  final int? urgent;
  final String urgent_name;
  final int ujt_id;
  final int ujt;
  final int primary_status;
  final employeeGetModel? primary_driver;
  final int secondary_status;
  final employeeGetModel? secondary_driver;
  final List<String>? order_image;
  final int returned;

  deliveryGetModel({
    this.id = 0,
    this.company_id = 0,
    this.company_name = "",
    this.bisnis_id = 0,
    this.bisnis_name = "",
    this.schedule_no = "",
    this.schedule_date = "",
    this.delivery_no = "",
    this.delivery_date = "",
    this.order_type_id = 0,
    this.order_type_name = "",
    this.customer_id = 0,
    this.customer_name = "",
    this.origin_id = 0,
    this.origin_name = "",
    this.plant_id = 0,
    this.plant_name = "",
    this.fleet_type_id = 0,
    this.fleet_type_name = "",
    this.multi_product = 0,
    this.product_id = 0,
    this.product_name = "",
    this.fleet_id = 0,
    this.plate_no = "",
    this.sj_customer = "",
    this.urgent = 0,
    this.urgent_name = "",
    this.employee_id = 0,
    this.employee_name = "",
    this.rekening_no = "",
    this.nama_rekening = "",
    this.image = "",
    this.confirm_ujt = 0,
    this.ujt_id = 0,
    this.ujt = 0,
    this.primary_status = 0,
    this.primary_driver,
    this.secondary_status = 0,
    this.secondary_driver,
    this.order_image,
    this.returned = 0,
  });

  factory deliveryGetModel.fromJson(Map<String, dynamic> item) {
    var urgent = item['schedule_id']['urgent'] == 1 ? "Urgent" : "Reguler";
    var image_data = item['employee_id']['image_data'];
    var image = '';

    if (image_data != null) {
      if (image_data.toString().contains("jpeg")) {
        image = image_data.substring(23, image_data.length);
      } else {
        image = image_data.substring(22, image_data.length);
      }
    }

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

    var order_image_data = item['image_data'];

    List<String> _imageOrder = [];
    if (order_image_data != null) {
      order_image_data.forEach((v) {
        var imageString = v['image_data'];
        var image = "";
        if (imageString.toString().contains("jpeg")) {
          image = imageString.substring(23, imageString.length);
        } else {
          image = imageString.substring(22, imageString.length);
        }
        _imageOrder.add(image);
      });
    }

    return deliveryGetModel(
      id: item['id'],
      company_id: item['company_id']['id'],
      company_name: item['company_id']['name'],
      bisnis_id: item['sales_type_id']['id'],
      bisnis_name: item['sales_type_id']['name'],
      schedule_no: item['schedule_id']['schedule_no'],
      schedule_date: item['schedule_id']['issue_date'],
      delivery_no: item['reference_no'] == null ? "" : item['reference_no'],
      delivery_date: item['issue_date'] == null ? "" : item['issue_date'],
      order_type_id: item['order_type_id']['id'],
      order_type_name: item['order_type_id']['name'],
      customer_id: item['customer_id']['id'],
      customer_name: item['customer_id']['name'],
      origin_id: item['origin_id']['id'],
      origin_name: item['origin_id']['name'],
      plant_id: item['plant_id']['id'],
      plant_name: item['plant_id']['full_name'],
      fleet_type_id: item['fleet_type_id']['id'],
      fleet_type_name: item['fleet_type_id']['name'],
      multi_product: item['multi_product'],
      product_id: item['product_id']['id'],
      product_name: item['product_id']['name'],
      fleet_id: item['fleet_id']['id'],
      plate_no: item['fleet_id']['plate_no'],
      sj_customer: item['sj_customer'],
      employee_name: item['employee_id']['name'],
      rekening_no: item['employee_id']['bank_no'],
      nama_rekening: item['employee_id']['bank_account_name'],
      image: image_data == null ? '' : image,
      confirm_ujt: item['confirm_ujt'],
      urgent: item['schedule_id']['urgent'],
      urgent_name: urgent,
      ujt_id: item['ujt_id'],
      ujt: item['ujt'],
      primary_status: item['primary_status'],
      primary_driver: _employeePrimary,
      secondary_status: item['secondary_status'],
      secondary_driver: _employeeSecondary,
      order_image: _imageOrder,
      returned: item['returned'] == null ? 0 : item['returned'],
    );
  }

  static Future<APIResponse<deliveryGetModel>> postDelivery(
      Map<String, String> form) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString('token');

    const API = sgBaseURL;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token.toString(),
    };

    final model = new deliveryGetModel();
    var request = new http.MultipartRequest(
        "POST", Uri.parse(API + 'order/cargo/detail'));

    request.headers.addAll(headers);
    request.fields.addAll(form);

    http.Response response =
        await http.Response.fromStream(await request.send());

    final message = json.decode(response.body)['errmsg'];
    final data = json.decode(response.body)['data'];

    if (response.statusCode == 200) {
      final jsonData = json.decode(data.body)['data'];

      return APIResponse<deliveryGetModel>(
        data: deliveryGetModel.fromJson(jsonData),
        message: message,
      );
    }

    return APIResponse<deliveryGetModel>(
      status: true,
      data: model,
      message: message,
    );
  }
}
