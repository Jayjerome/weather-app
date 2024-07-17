import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:renmoney/models/weather_model.dart';

class StorageService extends GetxService {

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  late FlutterSecureStorage storage;

  Future<StorageService> init() async {
    storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    return this;
  }

  Future<void> saveWeatherModelsToStorage(List<WeatherModel> weatherModels) async {
    if (weatherModels.length != 3) {
      throw Exception('Kindly select 3 cities');
    }
    String jsonString = weatherModelToJson(weatherModels);
    await storage.write(key: 'weatherModels', value: jsonString);
  }

  Future<List<WeatherModel>> getWeatherModelsFromStorage() async {
    String? jsonString = await storage.read(key: 'weatherModels');
    if (jsonString == null) {
      return [];
    }
    return weatherModelFromJson(jsonString);
  }

}
