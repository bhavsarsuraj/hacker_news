import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/app/app_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/constants.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: Strings.appTitle,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      onInit: () {
        Get.put(AppController());
      },
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: PrimaryColors.scaffoldBackgroundColor,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
