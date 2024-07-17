import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:renmoney/controller/app_controller.dart';
import 'package:renmoney/core/apiClient/network_helper.dart';
import 'package:renmoney/routes/pages.dart';
import 'package:renmoney/services/storage_service.dart';


Future<void> initServices() async {
  Get.put<GetMaterialController>(GetMaterialController());
  await Get.putAsync<StorageService>(() => StorageService().init());
  await Get.putAsync<NetworkHelper>(() => NetworkHelper().init());
  Get.put<AppController>(AppController());
}

main() async {
  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: Pages.routes,
        initialRoute: Pages.initial,
        theme: ThemeData(
            fontFamily: 'Satoshi',
            visualDensity: VisualDensity.adaptivePlatformDensity,
            canvasColor: Colors.transparent),
      ),
    );
  }
}
