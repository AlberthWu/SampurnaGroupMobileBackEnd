import 'dart:convert';
import 'dart:io';
import 'package:asm/app/constant/color.dart';
import 'package:asm/app/models/orders/surat_jalan/get.dart';
import 'package:asm/app/models/orders/surat_jalan/list.dart';
import 'package:http/http.dart' as http;
import 'package:asm/app/models/api_response.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class deliveryService {
  static const API = sgBaseURL;
  static const headers = {
    'Content-Type': 'application/json',
  };

  Future<APIResponse<List<deliveryListModel>>> GetList(date, page, keyword) {
    final models = <deliveryListModel>[];
    return http
        .get(
            Uri.parse(API +
                '/order/cargo/detail?issue_date=$date&pagesize=50&page=$page&keyword=$keyword'),
            headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data']['list'];
          for (var item in jsonData) {
            models.add(deliveryListModel.fromJson(item));
          }
          return APIResponse<List<deliveryListModel>>(data: models);
        }
        return APIResponse<List<deliveryListModel>>(
          status: true,
          message: message,
          data: models,
        );
      },
    ).catchError(
      (_) => APIResponse<List<deliveryListModel>>(
          status: true, message: 'An error occured!', data: models),
    );
  }

  Future<APIResponse<deliveryGetModel>> GetDelivery(int id) {
    final model = deliveryGetModel();
    return http
        .get(Uri.parse(API + 'order/cargo/detail/' + id.toString()),
            headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data'];

          return APIResponse<deliveryGetModel>(
            data: deliveryGetModel.fromJson(jsonData),
          );
        }
        return APIResponse<deliveryGetModel>(
          status: true,
          message: message,
          data: model,
        );
      },
    ).catchError(
      (_) => APIResponse<deliveryGetModel>(
        status: true,
        message: 'An error occured!',
        data: model,
      ),
    );
  }

  Future<APIResponse<bool>> PostConfirm(int id) async {
    var request = new http.MultipartRequest(
        "POST", Uri.parse(API + 'order/cargo/confirm/' + id.toString()));

    request.headers.addAll(headers);

    request.fields['status'] = '1';

    http.Response response =
        await http.Response.fromStream(await request.send());

    final message = json.decode(response.body)['errmsg'];

    if (response.statusCode == 200) {
      return APIResponse<bool>(
        data: true,
        message: message,
      );
    }

    return APIResponse<bool>(
      status: true,
      message: message,
      data: false,
    );
  }

  Future<APIResponse<deliveryGetModel>> PostDelivery(
      Map<String, String> form) async {
    final model = deliveryGetModel();
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
      message: message,
      data: model,
    );
  }

  Future<APIResponse<deliveryGetModel>> PutDelivery(
      int id, Map<String, String> form) async {
    final model = deliveryGetModel();
    var request = new http.MultipartRequest(
        "PUT", Uri.parse(API + 'order/cargo/detail/' + id.toString()));

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
      message: message,
      data: model,
    );
  }

  Future<APIResponse<bool>> UploadImage(int id, List<File> files) async {
    var request = new http.MultipartRequest(
        "POST", Uri.parse(API + 'order/cargo/image/' + id.toString()));

    request.headers.addAll(headers);

    for (var file in files) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyyMMdd-kk:mm').format(now);
      var bytes = new File(file.path).readAsBytesSync();

      var picture = http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: formattedDate + ".jpg",
      );

      request.files.addAll([picture]);
    }

    // for (var file in files) {
    //   request.files.addAll([
    //     http.MultipartFile.fromBytes(
    //       'file',
    //       File(file.path).readAsBytesSync(),
    //       filename: basename(file.path),
    //     ),
    //   ]);
    // }

    http.Response response =
        await http.Response.fromStream(await request.send());

    final message = json.decode(response.body)['errmsg'];

    if (response.statusCode == 200) {
      return APIResponse<bool>(
        data: true,
      );
    }

    return APIResponse<bool>(
      status: true,
      message: message,
      data: false,
    );
  }
}
