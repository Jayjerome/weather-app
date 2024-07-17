import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:renmoney/controller/app_controller.dart';
import 'package:renmoney/routes/routes.dart';
import 'package:renmoney/utils/color_palette.dart';

import '../components/widgets.dart';

class WeatherDashboard extends GetView<AppController> {
  const WeatherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              buildText("Today's forecast across\nYour favourite cities",
                  fontSize: 20, fontWeight: FontWeight.w700),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => controller.homeWeatherData.isNotEmpty
                    ? CarouselSlider(
                        options: CarouselOptions(
                          height: size.height * .6,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          enableInfiniteScroll: false,
                        ),
                        items:
                            controller.homeWeatherData.map((weather) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                          child: buildText(
                                              DateFormat("h:mm a")
                                                  .format(controller.now),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 25)),
                                      Center(
                                          child: buildText(
                                              DateFormat("EEEE")
                                                  .format(controller.now),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                          child: Image.network(
                                              "https://openweathermap.org/img/wn/${weather.weather[0].icon}@4x.png")),
                                      Center(
                                          child: buildText(
                                              "${(weather.main.temp - 273.15).toStringAsFixed(0)}° C",
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      weatherInfo("City", weather.name),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      weatherInfo(
                                          "Weather", weather.weather[0].main),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      weatherInfo("Description",
                                          weather.weather[0].description),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      )
                    : const Center(child: CupertinoActivityIndicator()),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: controller.homeWeatherData.isNotEmpty,
                child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(kPrimaryColor),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            kPrimaryColor.withOpacity(.2)),
                        elevation: MaterialStateProperty.all<double>(0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                    onPressed: () {
                      Get.toNamed(Routes.editDefault);
                    },
                    child: buildText('Change default cities',
                        color: kBlackColor, fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        tooltip: 'Current location',
        elevation: 5,
        onPressed: () {
          controller.getWeatherConditions();
          Get.toNamed(Routes.currentLocation);
        },
        child: const Icon(Icons.location_on_outlined,
            color: Colors.white, size: 28),
      ),
    );
  }
}
