import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/employee/get.dart';
import 'package:asm/app/models/employee/list.dart';

class employeeService {
  static const API = "https://api.sampurna-group.com/v1/";
  static const headers = {
    'Content-Type': 'application/json',
  };

  Future<APIResponse<List<employeeListModel>>> GetEmployeeList(page, keyword) {
    final models = <employeeListModel>[];
    return http
        .get(
            Uri.parse(
                API + '/employee?pagesize=20&page=$page&keyword=$keyword'),
            headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data']['list'];
          for (var item in jsonData) {
            models.add(employeeListModel.fromJson(item));
          }
          return APIResponse<List<employeeListModel>>(data: models);
        }
        return APIResponse<List<employeeListModel>>(
          status: true,
          message: message,
          data: models,
        );
      },
    ).catchError(
      (_) => APIResponse<List<employeeListModel>>(
          status: true, message: 'An error occured!', data: models),
    );
  }

  Future<APIResponse<employeeGetModel>> GetEmployee(int id) {
    final model = employeeGetModel();
    return http
        .get(Uri.parse(API + '/employee/' + id.toString()), headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data'];

          return APIResponse<employeeGetModel>(
            data: employeeGetModel.fromJson(jsonData),
          );
        }
        return APIResponse<employeeGetModel>(
          status: true,
          message: message,
          data: model,
        );
      },
    ).catchError(
      (_) => APIResponse<employeeGetModel>(
        status: true,
        message: 'An error occured!',
        data: model,
      ),
    );
  }

  Future<APIResponse<bool>> PostEmployee(Map<String, dynamic> data) {
    return http
        .post(
      Uri.parse(API + '/employee'),
      headers: headers,
      body: data,
    )
        .then(
      (data) {
        if (data.statusCode == 200) {
          return APIResponse<bool>(data: true);
        }
        return APIResponse<bool>(
          status: true,
          message: 'An error occured!',
          data: false,
        );
      },
    ).catchError(
      (_) => APIResponse<bool>(
        status: true,
        message: 'An error occured!',
        data: false,
      ),
    );
  }

  Future<APIResponse<bool>> PutEmployee(int id, Map<String, dynamic> data) {
    return http
        .put(
      Uri.parse(API + '/employee/' + id.toString()),
      headers: headers,
      body: data,
    )
        .then(
      (data) {
        if (data.statusCode == 200) {
          return APIResponse<bool>(data: true);
        }
        return APIResponse<bool>(
          status: true,
          message: 'An error occured!',
          data: false,
        );
      },
    ).catchError(
      (_) => APIResponse<bool>(
        status: true,
        message: 'An error occured!',
        data: false,
      ),
    );
  }
}
