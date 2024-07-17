import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renmoney/utils/color_palette.dart';

void showSnackBar(String message, bool isError) {
  Future.delayed(const Duration(milliseconds: 10), () async {
    while (Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
    }
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(message,
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: kWhiteColor,
            )),
        backgroundColor: isError ? Colors.red : Colors.green,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.none,
        duration: const Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        borderRadius: 8,
      ),
    );
  });
}