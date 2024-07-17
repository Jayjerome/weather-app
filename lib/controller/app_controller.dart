import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:renmoney/core/repository/account_repository.dart';
import 'package:renmoney/models/http_response_model.dart';
import 'package:renmoney/models/weather_data.dart';
import 'package:renmoney/models/weather_model.dart';
import 'package:renmoney/routes/routes.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:renmoney/services/storage_service.dart';
import 'package:renmoney/utils/utils.dart';

class AppController extends GetxController {
  AppRepository appRepository = AppRepository();
  StorageService storageService = Get.find();

  List<WeatherModel> weatherDataFile = [];
  var selectedWeatherDataFile = <WeatherModel>[].obs;

  RxDouble currentLatitude = 0.0.obs;
  RxDouble currentLongitude = 0.0.obs;

  var homeWeatherData = <WeatherData>[].obs;

  Rxn<WeatherData> userWeatherData = Rxn();
  DateTime now = DateTime.now();

  @override
  void onInit() {
    initialise();
    super.onInit();
  }

  initialise() async {
    Timer(const Duration(seconds: 3), () async {
      Get.offNamed(Routes.dashboard);
      getUserCurrentLocation();
    });
    now = DateTime.now();
    weatherDataFile = await loadJsonData();
    getDefault();
  }

  getDefault() async {
    List<WeatherModel> retrievedWeatherModels =
        await storageService.getWeatherModelsFromStorage();
    if (retrievedWeatherModels.isNotEmpty) {
      selectedWeatherDataFile.value = retrievedWeatherModels;
    } else {
      selectedWeatherDataFile.add(weatherDataFile[0]);
      selectedWeatherDataFile.add(weatherDataFile[2]);
      selectedWeatherDataFile.add(weatherDataFile[3]);
    }
    getDefaultWeatherDataInfo();
  }

  getDefaultWeatherDataInfo() async {
    homeWeatherData.clear();
    Future.wait([
      getWeatherConditionsWithLatLng(
          double.parse(selectedWeatherDataFile[0].lat),
          double.parse(selectedWeatherDataFile[0].lng),
          0),
      getWeatherConditionsWithLatLng(
          double.parse(selectedWeatherDataFile[1].lat),
          double.parse(selectedWeatherDataFile[1].lng),
          1),
      getWeatherConditionsWithLatLng(
          double.parse(selectedWeatherDataFile[2].lat),
          double.parse(selectedWeatherDataFile[2].lng),
          2),
    ]);
  }

  Future<List<WeatherModel>> loadJsonData() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/ng.json');
      List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((json) => WeatherModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getWeatherConditions() async {
    try {
      HTTPResponseModel response = await appRepository.getWeatherData(
          currentLatitude.value, currentLongitude.value);
      final weatherData = weatherDataFromJson(response.all);
      userWeatherData.value = weatherData;
      now = DateTime.now();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getWeatherConditionsWithLatLng(
      double lat, double long, int index) async {
    try {
      HTTPResponseModel response =
          await appRepository.getWeatherData(lat, long);
      final weatherData = weatherDataFromJson(response.all);
      homeWeatherData.add(weatherData);
      now = DateTime.now();
    } catch (e) {
      throw Exception(e);
    }
  }

  getUserCurrentLocation() async {
    setLocation();
    LocationPermission permission;
    await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar('Location permissions are denied', true);
      }
    } else if (permission == LocationPermission.deniedForever) {
      showSnackBar(
          'Location permissions are permanently denied,please enable it from app setting',
          true);
    } else {
      setLocation();
    }
  }

  setLocation() async {
    try {
      await Geolocator.getCurrentPosition().then((value) async {
        currentLongitude.value = value.longitude;
        currentLatitude.value = value.latitude;
      });
    } catch (e) {
    }
  }

  void toggleSelection(WeatherModel item) {
    if (selectedWeatherDataFile.contains(item)) {
      selectedWeatherDataFile.remove(item);
    } else {
      if (selectedWeatherDataFile.length < 3) {
        selectedWeatherDataFile.add(item);
      } else {
        showSnackBar('You can only select up to 3 cities.', true);
      }
    }
  }

  void saveDefaultLocations() async {
    try {
      await storageService
          .saveWeatherModelsToStorage(selectedWeatherDataFile);
      showSnackBar('Locations updates successfully', false);
      Get.back();
      getDefault();
    }catch(e){
      showSnackBar(e.toString(), true);
    }
  }
}
