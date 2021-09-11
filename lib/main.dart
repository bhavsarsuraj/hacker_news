import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/constants.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: Strings.appTitle,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            wordSpacing: 2,
          ),
          subtitle1: TextStyle(
            wordSpacing: 2,
          ),
          subtitle2: TextStyle(
            wordSpacing: 2,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
