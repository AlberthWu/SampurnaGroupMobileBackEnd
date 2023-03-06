import 'package:asm/app/constant/app_constant.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:http/http.dart' as http;

class globalService {
  static const API = sgBaseURL;
  static const headers = {
    'Content-Type': 'application/json',
  };

  Future<APIResponse<String>> GetServerDatetime() {
    return http.get(Uri.parse(API + 'getsvrdate'), headers: headers).then(
      (data) {
        if (data.statusCode == 200) {
          return APIResponse<String>(data: data.body);
        }
        return APIResponse<String>(
          status: true,
          data: "",
        );
      },
    ).catchError(
      (_) => APIResponse<String>(
          status: true, message: 'An error occured!', data: ""),
    );
  }
}
