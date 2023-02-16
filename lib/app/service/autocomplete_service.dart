import 'dart:convert';
import 'package:asm/app/constant/color.dart';
import 'package:http/http.dart' as http;
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/autocomplete_model.dart';

class autoCompleteService {
  static const API = sgBaseURL;
  static const headers = {
    'Content-Type': 'application/json',
  };

  Future<APIResponse<List<autocompleteListModel>>> GetCompanyList(keyword) {
    final models = <autocompleteListModel>[];
    return http
        .get(Uri.parse(API + '/internal?keyword=$keyword'), headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data']['list'];
          for (var item in jsonData) {
            models.add(autocompleteListModel.fromJson(item));
          }
          return APIResponse<List<autocompleteListModel>>(data: models);
        }
        return APIResponse<List<autocompleteListModel>>(
          status: false,
          message: message,
          data: models,
        );
      },
    ).catchError(
      (_) => APIResponse<List<autocompleteListModel>>(
        status: false,
        message: 'An error occured!',
        data: models,
      ),
    );
  }

  Future<APIResponse<List<autocompleteListModel>>> GetDepartmentList(keyword) {
    final models = <autocompleteListModel>[];
    return http
        .get(Uri.parse(API + '/department/list?keyword=$keyword'),
            headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data'];
          for (var item in jsonData) {
            models.add(autocompleteListModel.fromJson(item));
          }
          return APIResponse<List<autocompleteListModel>>(data: models);
        }
        return APIResponse<List<autocompleteListModel>>(
          status: false,
          message: message,
          data: models,
        );
      },
    ).catchError(
      (_) => APIResponse<List<autocompleteListModel>>(
        status: false,
        message: 'An error occured!',
        data: models,
      ),
    );
  }

  Future<APIResponse<List<autocompleteListModel>>> GetDivisionList(keyword) {
    final models = <autocompleteListModel>[];
    return http
        .get(Uri.parse(API + '/division/list?keyword=$keyword'),
            headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data'];
          for (var item in jsonData) {
            models.add(autocompleteListModel.fromJson(item));
          }
          return APIResponse<List<autocompleteListModel>>(data: models);
        }
        return APIResponse<List<autocompleteListModel>>(
          status: false,
          message: message,
          data: models,
        );
      },
    ).catchError(
      (_) => APIResponse<List<autocompleteListModel>>(
        status: false,
        message: 'An error occured!',
        data: models,
      ),
    );
  }

  Future<APIResponse<List<autocompleteListModel>>> GetOccupationList(keyword) {
    final models = <autocompleteListModel>[];
    return http
        .get(Uri.parse(API + '/occupation/list?keyword=$keyword'),
            headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data'];
          for (var item in jsonData) {
            models.add(autocompleteListModel.fromJson(item));
          }
          return APIResponse<List<autocompleteListModel>>(data: models);
        }
        return APIResponse<List<autocompleteListModel>>(
          status: false,
          message: message,
          data: models,
        );
      },
    ).catchError(
      (_) => APIResponse<List<autocompleteListModel>>(
        status: false,
        message: 'An error occured!',
        data: models,
      ),
    );
  }

  Future<APIResponse<List<autocompleteListModel>>> GetCityList(keyword) {
    final models = <autocompleteListModel>[];
    return http
        .get(Uri.parse(API + '/city/list?keyword=$keyword'), headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data'];
          for (var item in jsonData) {
            models.add(autocompleteListModel.fromJson(item));
          }
          return APIResponse<List<autocompleteListModel>>(data: models);
        }
        return APIResponse<List<autocompleteListModel>>(
          status: false,
          message: message,
          data: models,
        );
      },
    ).catchError(
      (_) => APIResponse<List<autocompleteListModel>>(
          status: false, message: 'An error occured!', data: models),
    );
  }

  Future<APIResponse<List<autocompleteListModel>>> GetBankList(keyword) {
    final models = <autocompleteListModel>[];
    return http
        .get(Uri.parse(API + '/bank?keyword=$keyword'), headers: headers)
        .then(
      (data) {
        final message = json.decode(data.body)['errmsg'];
        if (data.statusCode == 200) {
          final jsonData = json.decode(data.body)['data']['list'];
          for (var item in jsonData) {
            models.add(autocompleteListModel.fromJson(item));
          }
          return APIResponse<List<autocompleteListModel>>(data: models);
        }
        return APIResponse<List<autocompleteListModel>>(
          status: false,
          message: message,
          data: models,
        );
      },
    ).catchError(
      (_) => APIResponse<List<autocompleteListModel>>(
        status: false,
        message: 'An error occured!',
        data: models,
      ),
    );
  }
}
