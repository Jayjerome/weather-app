import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renmoney/controller/app_controller.dart';
import 'package:renmoney/utils/color_palette.dart';

import '../components/widgets.dart';

class EditDefaultCities extends GetView<AppController> {
  const EditDefaultCities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: kBlackColor,
                  )),
              const SizedBox(
                height: 30,
              ),
              buildText('Set default cities',
                  color: kBlackColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
              const SizedBox(
                height: 10,
              ),
              buildText('Select 3 cities to display on the home page',
                  color: kBlackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.weatherDataFile.length,
                    itemBuilder: (context, index) {
                      final weather = controller.weatherDataFile[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          child: ListTile(
                            title:
                                Text('${weather.city} - ${weather.adminName}'),
                            trailing: Obx(
                              ()=> Checkbox(
                                value: controller.selectedWeatherDataFile
                                    .contains(weather),
                                onChanged: (bool? value) {
                                  controller.toggleSelection(weather);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(kPrimaryColor),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            kPrimaryColor.withOpacity(.2)),
                        elevation: MaterialStateProperty.all<double>(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                    onPressed: () {
                      controller.saveDefaultLocations();
                    },
                    child: buildText('Save',
                        color: kBlackColor, fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
