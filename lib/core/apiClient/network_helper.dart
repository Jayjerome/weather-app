import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:renmoney/utils/api_enums.dart';
import 'package:renmoney/models/http_response_model.dart';
import 'package:renmoney/services/storage_service.dart';

class NetworkHelper extends GetxService {
  final Dio _dio = Dio();
  final storageService = Get.find<StorageService>();
  static const httpTimeoutDuration = 60;

  Future<NetworkHelper> init() async {
    _dio.options.baseUrl = baseUrl;
    var kHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    _dio.options.headers = kHeader;
    return this;
  }

  final kTimeoutResponse = Response(
    data: {"success": false, "message": "Connection Timeout"},
    statusCode: 400,
    requestOptions:
        RequestOptions(path: 'Error occurred while connecting to server'),
  );

  Future<HTTPResponseModel> runApi({
    String? from,
    required ApiRequestType type,
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool showError = true,
  }) async {
    Response res;
    try {
      switch (type) {
        case ApiRequestType.get:
          res = await _get(url: url, body: body);
          break;
        case ApiRequestType.post:
          res = await _post(url: url, body: body);
          break;
        case ApiRequestType.put:
          res = await _put(url: url, body: body);
          break;
        case ApiRequestType.patch:
          res = await _patch(url: url, body: body);
          break;
        case ApiRequestType.delete:
          res = await _delete(url: url, body: body);
          break;
        case ApiRequestType.formData:
          res = await _formData(url: url, body: body);
          break;
        case ApiRequestType.formDataPatch:
          res = await _formDataPatch(url: url, body: body);
          break;
      }

      debugPrint(res.toString());
      if (res.statusCode == 400) {
        return HTTPResponseModel.jsonToMap(
            {"success": false, "message": "Timeout"},
            res.statusCode!,
            "");
      }

      if (res.data is String) {
        return HTTPResponseModel.jsonToMap(
            {"success": false, "message": "Unable to process your request"},
            res.statusCode!,
            "");
      }

      return HTTPResponseModel.jsonToMap(
          res.data, res.statusCode!, res.headers.map['set-cookie']);
    } on DioException catch (error) {
      final int statusCode = error.response?.statusCode ?? 400;
      String errorMessage = "Your internet is not stable kindly reconnect and try again";

      return HTTPResponseModel.jsonToMap(
          error.error.toString().contains("SocketException")
              ? {"message": errorMessage}
              : error.response?.data,
          statusCode,
          "",
          errorMessage: errorMessage,
          success: false);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> _get({required String url, body}) async {
    return await _dio.get(url).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _post({required String url, body}) async {
    return await _dio.post(url, data: body).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _patch({required String url, body}) async {
    return await _dio.patch(url, data: body).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _put({required String url, body}) async {
    return await _dio.put(url, data: body).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _delete({required String url, body}) async {
    return await _dio.delete(url, data: body).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _formData({required String url, body}) async {
    FormData formData = FormData.fromMap(body);
    return await _dio.post(url, data: formData).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _formDataPatch({required String url, body}) async {
    FormData formData = FormData.fromMap(body);
    return await _dio.put(url, data: formData).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }
}
