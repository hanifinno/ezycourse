import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'color.dart';

void showSnackkbar(String s, {required String titile, required String message}) {
  Get.snackbar(
    titile,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: PRIMARY_COLOR,
    colorText: Colors.white,
  );
}

void showSuccessSnackkbar({String? titile, required String message, Color? bgColor}) {
  Get.snackbar(
    titile ?? 'SUCCESS!',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: bgColor?? PRIMARY_COLOR,
    colorText: Colors.white,
  );
}

void showWarningSnackkbar({String? titile, required String message}) {
  Get.snackbar(
    titile ?? 'WARNING!',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.yellow,
    colorText: Colors.black,
  );
}

void showErrorSnackkbar({String? titile, required String message}) {
  Get.snackbar(
    titile ?? 'ERROR!',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}
