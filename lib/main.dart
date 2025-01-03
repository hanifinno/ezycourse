import 'package:ezycourse/ezycourse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/utils/loader.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  await GetStorage.init();
  configLoader();
  // Get.lazyPut(() => MarketplaceController(), fenix: true);
  // Get.lazyPut(() => SellerPanelDashboardController(), fenix: true);
  // Get.lazyPut(() => CartController(), fenix: true);
  runApp(
    const EzyCourseApp(),
  );
}
