import 'package:get/instance_manager.dart';
import 'package:renmoney/core/apiClient/network_helper.dart';
import 'package:renmoney/utils/api_enums.dart';
import 'package:renmoney/models/http_response_model.dart';

class ApiClient {
  final NetworkHelper _networkHelper = Get.find();
  String apiKey = "266e273039b6561267840eb182a4e2dc";

  Future<HTTPResponseModel> getCurrentWeather(double lat, double long) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey",
    );
  }
}
