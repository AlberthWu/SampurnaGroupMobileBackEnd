import 'package:asm/app/models/errors_model.dart';

class restResponse<T> {
  bool status;
  String message;
  List<errorsModel>? errors;
  T data;

  restResponse({
    this.status = false,
    this.message = "",
    this.errors,
    required this.data,
  });
}
