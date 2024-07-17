import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:renmoney/components/widgets.dart';
import 'package:renmoney/controller/app_controller.dart';
import 'package:renmoney/utils/color_palette.dart';

class UseCurrentLocation extends GetView<AppController> {
  const UseCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            ()=> Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: ()=> Get.back(),
                    child: const Icon(Icons.arrow_back, color: kBlackColor,)),
                const SizedBox(height: 30,),
                buildText('Weather Forecast for your current location', color: kBlackColor,
                    fontSize: 20, fontWeight: FontWeight.w700),
                const SizedBox(height: 10,),
                buildText("Here's the weather for today", color: kBlackColor,
                    fontSize: 15, fontWeight: FontWeight.w500),
                const SizedBox(height: 50,),
                if(controller.userWeatherData.value != null)...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Center(child: buildText(DateFormat("h:mm a").format(controller.now), fontWeight: FontWeight.w700,
                              fontSize: 25)),
                          const SizedBox(height: 10,),
                          Center(child: buildText(DateFormat("EEEE").format(controller.now), fontWeight: FontWeight.w700,
                              fontSize: 20)),
                          const SizedBox(height: 10,),
                          Center(child: Image.network("https://openweathermap.org/img/wn/${controller.userWeatherData.value!.weather[0].icon}@4x.png")),
                          Center(child: buildText( "${(controller.userWeatherData.value!.main.temp - 273.15).toStringAsFixed(0)}° C", fontSize: 30, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 20,),
                          weatherInfo("City", controller.userWeatherData.value!.name),
                          const SizedBox(height: 10,),
                          weatherInfo("Weather", controller.userWeatherData.value!.weather[0].main),
                          const SizedBox(height: 10,),
                          weatherInfo("Description", controller.userWeatherData.value!.weather[0].description),
                        ],
                      ),
                    ),
                  ),
                ]else...[
                  const Center(child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CupertinoActivityIndicator(),
                  ))
                ]

              ],
            ),
          ),
        ),
      ),
    );
  }
}
