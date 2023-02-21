import 'dart:convert';
import 'dart:io';
import 'package:asm/app/constant/color.dart';
import 'package:http/http.dart' as http;
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/employee/get.dart';
import 'package:asm/app/models/employee/list.dart';

class employeeService {
  static const API = sgBaseURL;
  static const headers = {
    'Content-Type': 'application/json',
  };

  Future<APIResponse<List<employeeListModel>>> GetEmployeeList(page, keyword) {
    final models = <employeeListModel>[];
    return http
        .get(
            Uri.parse(API + 'employee?pagesize=20&page=$page&keyword=$keyword'),
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
        .get(Uri.parse(API + 'employee/' + id.toString()), headers: headers)
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

  // Future<APIResponse<bool>> PostEmployee(Map<String, dynamic> data) {
  //   return http
  //       .post(
  //     Uri.parse(API + 'employee'),
  //     headers: headers,
  //     body: data,
  //   )
  //       .then(
  //     (data) {
  //       if (data.statusCode == 200) {
  //         return APIResponse<bool>(data: true);
  //       }
  //       return APIResponse<bool>(
  //         status: true,
  //         message: 'An error occured!',
  //         data: false,
  //       );
  //     },
  //   ).catchError(
  //     (_) => APIResponse<bool>(
  //       status: true,
  //       message: 'An error occured!',
  //       data: false,
  //     ),
  //   );
  // }

  Future<APIResponse<employeeGetModel>> PostEmployee(
      Map<String, String> form, File image) async {
    final model = employeeGetModel();
    var request =
        new http.MultipartRequest("POST", Uri.parse(API + 'employee'));

    request.headers.addAll(headers);
    request.fields.addAll(form);

    request.files.add(
      new http.MultipartFile.fromBytes(
        "file",
        File(image.path).readAsBytesSync(),
        filename: "Image.jpg",
      ),
    );

    http.Response response =
        await http.Response.fromStream(await request.send());

    final message = json.decode(response.body)['errmsg'];
    final data = json.decode(response.body)['data'];

    if (response.statusCode == 200) {
      final jsonData = json.decode(data.body)['data'];

      return APIResponse<employeeGetModel>(
        data: employeeGetModel.fromJson(jsonData),
        message: message,
      );
    }

    return APIResponse<employeeGetModel>(
      status: true,
      message: message,
      data: model,
    );
  }

  Future<APIResponse<employeeGetModel>> PutEmployee(
      int id, Map<String, String> form, File image) async {
    final model = employeeGetModel();
    var request = new http.MultipartRequest(
        "PUT", Uri.parse(API + 'employee/' + id.toString()));

    request.headers.addAll(headers);
    request.fields.addAll(form);

    request.files.add(
      new http.MultipartFile.fromBytes(
        "file",
        File(image.path).readAsBytesSync(),
        filename: "Image.jpg",
      ),
    );

    http.Response response =
        await http.Response.fromStream(await request.send());

    final message = json.decode(response.body)['errmsg'];

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'];

      return APIResponse<employeeGetModel>(
        data: employeeGetModel.fromJson(jsonData),
        message: message,
      );
    }

    return APIResponse<employeeGetModel>(
      status: true,
      message: message,
      data: model,
    );
  }
}
