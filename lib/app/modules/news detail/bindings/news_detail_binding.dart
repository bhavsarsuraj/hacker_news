import 'package:get/get.dart';

import '../controllers/news_detail_controller.dart';

class NewsDetailBinding extends Bindings {
  @override
  void dependencies() {
    final objectId = Get.arguments as String;
    Get.lazyPut<NewsDetailController>(
      () => NewsDetailController(objectId: objectId),
    );
  }
}
