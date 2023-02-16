import 'dart:convert';
import 'package:asm/app/models/orders/surat_jalan/get.dart';
import 'package:asm/app/models/orders/surat_jalan/list.dart';
import 'package:http/http.dart' as http;
import 'package:asm/app/models/api_response.dart';

class deliveryService {
  static const API = "https://api.sampurna-group.com/v1/";
  static const headers = {
    'Content-Type': 'application/json',
  };

  Future<APIResponse<List<deliveryListModel>>> GetList(date, page, keyword) {
    final models = <deliveryListModel>[];
    return http
        .get(
            Uri.parse(API +
                '/order/cargo/detail?pagesize=20&page=$page&keyword=$keyword'),
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
        .get(Uri.parse(API + '/order/cargo/detail/' + id.toString()),
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
        "POST", Uri.parse(API + '/order/cargo/confirm/' + id.toString()));

    request.headers.addAll(headers);

    request.fields['status'] = '1';

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      return APIResponse<bool>(data: true);
    }

    final message = json.decode(response.body)['errmsg'];
    return APIResponse<bool>(
      status: true,
      message: message,
      data: false,
    );
  }
}
