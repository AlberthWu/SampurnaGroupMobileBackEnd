import 'dart:convert';
import 'package:asm/app/constant/color.dart';
import 'package:asm/app/models/orders/driver.dart';
import 'package:http/http.dart' as http;
import 'package:asm/app/models/api_response.dart';

class driverService {
  static const API = sgBaseURL;
  static const headers = {
    'Content-Type': 'application/json',
  };

  Future<APIResponse<driverGetModel>> GetDriver(
      String issueDate, String plateNo) {
    final model = driverGetModel();

    return http
        .get(
            Uri.parse(API +
                'fleetformation/driver?issue_date=$issueDate&plate_no=$plateNo'),
            headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data'];

          return APIResponse<driverGetModel>(
            data: driverGetModel.fromJson(jsonData),
          );
        }
        return APIResponse<driverGetModel>(
          status: true,
          message: message,
          data: model,
        );
      },
    ).catchError(
      (_) => APIResponse<driverGetModel>(
        status: true,
        message: 'An error occured!',
        data: model,
      ),
    );
  }
}
