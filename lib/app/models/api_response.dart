class APIResponse<T> {
  bool status;
  String message;
  T data;

  APIResponse({this.status = false, this.message = "", required this.data});
}
