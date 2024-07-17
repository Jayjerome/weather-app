import 'package:dio/dio.dart';
import 'package:renmoney/core/apiClient/api_client.dart';
import 'package:renmoney/models/http_response_model.dart';

class AppRepository {
  final ApiClient apiClient = ApiClient();

  Future<HTTPResponseModel> getWeatherData(double lat, double long) async {
    try {
      HTTPResponseModel response = await apiClient.getCurrentWeather(lat, long);
      return response;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
