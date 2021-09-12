import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/app/utils/constants.dart';

class AppController extends GetxController {
  StreamSubscription subscription;

  @override
  void onInit() {
    super.onInit();
    checkConnection();
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      handleConnection(result);
    });
  }

  void checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    handleConnection(result);
  }

  void handleConnection(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Get.bottomSheet(
        WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.verticalPadding,
                horizontal: Dimensions.horizntalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Image(
                      fit: BoxFit.fitWidth,
                      image: AssetImage(Images.noInternet),
                    ),
                  ),
                  Divider(),
                  TextButton(
                    onPressed: () {
                      AppSettings.openWIFISettings();
                    },
                    child: Text(
                      Strings.openSettings,
                      style: TextStyle(
                        fontSize: Dimensions.titleTextSize,
                        color: PrimaryColors.primaryGrey,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ignoreSafeArea: false,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
      );
    } else {
      // Internet
      if (Get.isBottomSheetOpen ?? false) Get.back();
    }
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }
}
