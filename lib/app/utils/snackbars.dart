import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';

import 'constants.dart';

class Snackbars {
  static GetBar errorSnackBar({@required String message}) {
    return GetBar(
      title: Strings.error.tr,
      message: message.tr,
      duration: Duration(seconds: 2),
    );
  }
}
