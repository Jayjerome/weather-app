import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renmoney/controller/app_controller.dart';
import 'package:renmoney/utils/color_palette.dart';

import '../components/widgets.dart';

class SplashScreen extends GetView<AppController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/splash.jpg'),
                fit: BoxFit.fill)),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildText('Weather Forecast',
                color: kWhiteColor, fontSize: 30, fontWeight: FontWeight.w700),
            const SizedBox(
              height: 10,
            ),
            buildText('Stay updated with daily weather forecasts',
                color: kWhiteColor, fontSize: 15, fontWeight: FontWeight.w500),
          ],
        )),
      ),
    );
  }
}
