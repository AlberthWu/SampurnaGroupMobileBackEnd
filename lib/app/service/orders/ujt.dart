import 'dart:convert';
import 'package:asm/app/constant/app_constant.dart';
import 'package:asm/app/models/orders/ujt.dart';
import 'package:http/http.dart' as http;
import 'package:asm/app/models/api_response.dart';

class ujtService {
  static const API = sgBaseURL;
  static const headers = {
    'Content-Type': 'application/json',
  };

  Future<APIResponse<ujtGetModel>> GetUjt(String issueDate, int plantID,
      int originID, int fleetTypeID, int productID) {
    final model = ujtGetModel();

    return http
        .get(
            Uri.parse(API +
                'ujt/get?issue_date=$issueDate&plant_id=$plantID&origin_id=$originID&fleet_type_id=$fleetTypeID&product_id=$productID'),
            headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data'];

          return APIResponse<ujtGetModel>(
            data: ujtGetModel.fromJson(jsonData),
          );
        }
        return APIResponse<ujtGetModel>(
          status: true,
          message: message,
          data: model,
        );
      },
    ).catchError(
      (_) => APIResponse<ujtGetModel>(
        status: true,
        message: 'An error occured!',
        data: model,
      ),
    );
  }
}
