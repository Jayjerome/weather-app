import 'dart:convert';

class HTTPResponseModel {
  HTTPResponseModel();

  int? _code;
  bool? _success;
  String? _message;
  dynamic _error;
  String? _errorMessage;
  dynamic _data;
  dynamic _all;
  dynamic _result;
  String? _token;

  int get code => _code!;
  bool get success => _success!;
  String? get message => _message;
  dynamic get error => _error;
  String get errorMessage => _errorMessage!;
  dynamic get data => _data;
  dynamic get all => _all;
  dynamic get result => _result;
  String? get token => _token;

  set setSuccess(int code) => _code = code;
  set setStatus(bool success) => _success = success;
  set setErrorMessage(String message) => _message = message;
  set setError(error) => _error = error;
  set setData(data) => _data = data;
  set setAll(all) => _all = all;
  set serToken(token) => _token = token;

  HTTPResponseModel.jsonToMap(
      Map<dynamic, dynamic> parsedJson, int statusCode, dynamic token,
      {String? errorMessage, bool? success}) {
    _token = token != null && token.isNotEmpty
        ? token[0].split(';')[0].split('=')[1]
        : "";
    _code = statusCode;
    _success = success ?? (parsedJson['success'] ?? false);
    _message = parsedJson['message'].toString();
    _error = parsedJson['errors'];
    _errorMessage = errorMessage;
    _data = jsonEncode(parsedJson['data']);
    _result = jsonEncode(parsedJson['result']);
    _all = jsonEncode(parsedJson);
  }
}

class ErrorResponseModel {
  ErrorResponseModel(
      {this.success = false,
        this.code = 400,
        required this.error});
  final bool success;
  final int code;
  final String error;
}
