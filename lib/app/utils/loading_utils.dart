import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingUtils {
  static var _isLoaderShowing = false;

  static void showLoader() {
    if (!_isLoaderShowing) {
      Get.dialog(
        WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Center(child: CircularProgressIndicator()),
        ),
        barrierDismissible: false,
      );
      _isLoaderShowing = true;
    } else {
      hideLoader();
      showLoader();
    }
  }

  static void hideLoader() {
    if (_isLoaderShowing) {
      Get.back();
      _isLoaderShowing = false;
    }
  }
}
