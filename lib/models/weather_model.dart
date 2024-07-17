// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

List<WeatherModel> weatherModelFromJson(String str) => List<WeatherModel>.from(json.decode(str).map((x) => WeatherModel.fromJson(x)));

String weatherModelToJson(List<WeatherModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WeatherModel {
  String city;
  String lat;
  String lng;
  String country;
  String iso2;
  String adminName;
  String capital;
  String population;
  String populationProper;

  WeatherModel({
    required this.city,
    required this.lat,
    required this.lng,
    required this.country,
    required this.iso2,
    required this.adminName,
    required this.capital,
    required this.population,
    required this.populationProper,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    city: json["city"],
    lat: json["lat"],
    lng: json["lng"],
    country: json["country"],
    iso2: json["iso2"],
    adminName: json["admin_name"],
    capital: json["capital"],
    population: json["population"],
    populationProper: json["population_proper"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "lat": lat,
    "lng": lng,
    "country": country,
    "iso2": iso2,
    "admin_name": adminName,
    "capital": capital,
    "population": population,
    "population_proper": populationProper,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WeatherModel &&
              runtimeType == other.runtimeType &&
              city == other.city &&
              lat == other.lat &&
              lng == other.lng &&
              country == other.country &&
              iso2 == other.iso2 &&
              adminName == other.adminName &&
              capital == other.capital &&
              population == other.population &&
              populationProper == other.populationProper;

  @override
  int get hashCode =>
      city.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      country.hashCode ^
      iso2.hashCode ^
      adminName.hashCode ^
      capital.hashCode ^
      population.hashCode ^
      populationProper.hashCode;
}
