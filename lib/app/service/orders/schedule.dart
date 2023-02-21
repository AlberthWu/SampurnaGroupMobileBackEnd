import 'dart:convert';
import 'package:asm/app/constant/color.dart';
import 'package:asm/app/models/orders/schedule/get.dart';
import 'package:http/http.dart' as http;
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/orders/schedule/list.dart';

class scheduleService {
  static const API = sgBaseURL;
  static const headers = {
    'Content-Type': 'application/json',
  };

  Future<APIResponse<List<scheduleListModel>>> GetList(date, page, keyword) {
    final models = <scheduleListModel>[];
    return http
        .get(
            Uri.parse(API +
                'order/schedule?issue_date=$date&pagesize=20&page=$page&keyword=$keyword'),
            headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data']['list'];
          for (var item in jsonData) {
            models.add(scheduleListModel.fromJson(item));
          }
          return APIResponse<List<scheduleListModel>>(data: models);
        }
        return APIResponse<List<scheduleListModel>>(
          status: true,
          message: message,
          data: models,
        );
      },
    ).catchError(
      (_) => APIResponse<List<scheduleListModel>>(
          status: true, message: 'An error occured!', data: models),
    );
  }

  Future<APIResponse<scheduleGetModel>> GetSchedule(int id) {
    final model = scheduleGetModel();
    return http
        .get(Uri.parse(API + 'order/schedule/' + id.toString()),
            headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data'];

          return APIResponse<scheduleGetModel>(
            data: scheduleGetModel.fromJson(jsonData),
          );
        }
        return APIResponse<scheduleGetModel>(
          status: true,
          message: message,
          data: model,
        );
      },
    ).catchError(
      (_) => APIResponse<scheduleGetModel>(
        status: true,
        message: 'An error occured!',
        data: model,
      ),
    );
  }
}
