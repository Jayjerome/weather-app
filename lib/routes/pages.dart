import 'package:get/get.dart';
import 'package:renmoney/bindings/app_binding.dart';
import 'package:renmoney/screens/current_location_screen.dart';
import 'package:renmoney/screens/edit_default_cities_screeen.dart';
import 'package:renmoney/screens/splash_screen.dart';
import 'package:renmoney/screens/weather_dashboard.dart';
import 'routes.dart';

class Pages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
        name: Routes.splash,
        page: () => const SplashScreen(),
        binding: AppBindings()),
    GetPage(
        name: Routes.dashboard,
        page: () => const WeatherDashboard(),
        binding: AppBindings()),
    GetPage(
        name: Routes.editDefault,
        page: () => const EditDefaultCities(),
        binding: AppBindings()),
    GetPage(
        name: Routes.currentLocation,
        page: () => const UseCurrentLocation(),
        binding: AppBindings()),
  ];
}
